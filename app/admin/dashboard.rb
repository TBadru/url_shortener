ActiveAdmin.register_page "Dashboard" do
  content title: "Admin Dashboard" do
    columns do
      # -------------------
      # Column 1: Top URLs
      # -------------------
      column do
        panel "🔥 Top 10 URLs by Clicks",
              class: "bg-gradient-to-r from-purple-500 via-pink-500 to-red-500 text-white rounded-xl shadow-lg p-6 mb-6" do
          table_for Url.order(clicks: :desc).limit(10),
                    class: "table-auto w-full text-gray-100" do
            column :slug
            column :original_url
            column :clicks
            column :expires_at
          end
        end
      end

      # -------------------
      # Column 2: Charts
      # -------------------
      column do
        panel "📈 Clicks Per Day (Last 30 Days)",
              class: "bg-gradient-to-r from-green-400 via-teal-400 to-blue-500 text-white rounded-xl shadow-lg p-6 mb-6" do
          div class: "p-2" do
            line_chart Click.group_by_day(:created_at, last: 30).count,
                       height: "300px",
                       library: {
                         backgroundColor: "transparent",
                         responsive: true,
                         legend: { labels: { color: "#fff" } },
                         scales: {
                           x: { ticks: { color: "#fff" }, grid: { color: "rgba(255,255,255,0.2)" } },
                           y: { ticks: { color: "#fff" }, grid: { color: "rgba(255,255,255,0.2)" } }
                         }
                       }
          end
        end

        panel "🌐 Top Referrers (Last 30 Days)",
              class: "bg-gradient-to-r from-yellow-400 via-orange-400 to-red-500 text-white rounded-xl shadow-lg p-6 mb-6" do
          div class: "p-2" do
            pie_chart Click.where("created_at >= ?", 30.days.ago)
                           .group("COALESCE(referrer, 'Direct')")
                           .order("count_all DESC")
                           .limit(10)
                           .count,
                      height: "300px",
                      library: { backgroundColor: "transparent", legend: { labels: { color: "#fff" } } }
          end
        end
      end
    end

    # -------------------
    # Recent Clicks Table
    # -------------------
    panel "🖱️ Recent Clicks",
          class: "bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 text-white rounded-xl shadow-lg p-6" do
      table_for Click.order(created_at: :desc).limit(20),
                class: "table-auto w-full text-gray-100" do
        column :url do |click|
          link_to click.url.slug,
                  admin_url_path(click.url),
                  class: "text-yellow-200 hover:underline"
        end
        column :ip_address
        column :referrer
        column :created_at do |click|
          time_ago_in_words(click.created_at) + " ago"
        end
      end
    end
  end
end
