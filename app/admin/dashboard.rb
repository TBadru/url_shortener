ActiveAdmin.register_page "Dashboard" do
  content title: "Admin Dashboard" do
    columns do
      # -------------------
      # Column 1: Top URLs
      # -------------------
      column do
        panel "🔥 Top 10 URLs by Clicks",
              class: "panel-gradient from-purple-500 via-pink-500 to-red-500 text-white rounded-xl shadow-lg p-6 mb-6" do
          table_for Url.order(clicks: :desc).limit(10),
                    class: "table-auto w-full text-white" do
            column :slug do |url|
              span "🔗", class: "mr-1"
              url.slug
            end
            column :original_url do |url|
              link_to url.original_url, url.original_url, target: "_blank", class: "hover:underline text-white"
            end
            column :clicks do |url|
              span url.clicks, class: "inline-block bg-white text-purple-600 px-2 py-1 rounded-full font-bold"
            end
            column :expires_at do |url|
              if url.expires_at && url.expires_at < Time.current
                span "Expired", class: "bg-red-600 px-2 py-1 rounded-full text-white font-bold"
              else
                span "Active", class: "bg-green-500 px-2 py-1 rounded-full text-white font-bold"
              end
            end
          end
        end
      end

      # -------------------
      # Column 2: Charts
      # -------------------
      column do
        panel "📈 Clicks Per Day (Last 30 Days)",
              class: "panel-gradient from-green-400 via-teal-400 to-blue-400 text-white rounded-xl shadow-lg p-6 mb-6" do
          div class: "p-2" do
            line_chart Click.group_by_day(:created_at, last: 30).count,
                       height: "300px", library: { backgroundColor: "transparent" }
          end
        end

        panel "🌐 Top Referrers (Last 30 Days)",
              class: "panel-gradient from-yellow-400 via-orange-400 to-red-400 text-white rounded-xl shadow-lg p-6 mb-6" do
          div class: "p-2" do
            pie_chart Click.where("created_at >= ?", 30.days.ago)
                           .group("COALESCE(referrer, 'Direct')")
                           .order("count_all DESC")
                           .limit(10)
                           .count,
                      library: { backgroundColor: "transparent" }
          end
        end
      end
    end

    # -------------------
    # Recent Clicks Table
    # -------------------
    panel "🖱️ Recent Clicks",
          class: "panel-gradient from-indigo-400 via-purple-400 to-pink-400 text-white rounded-xl shadow-lg p-6" do
      table_for Click.order(created_at: :desc).limit(20),
                class: "table-auto w-full text-white" do
        column :url do |click|
          link_to click.url.slug,
                  admin_url_path(click.url),
                  class: "text-white font-semibold hover:text-yellow-300 hover:underline transition"
        end
        column :ip_address do |click|
          span "🌐", class: "mr-1"
          click.ip_address
        end
        column :referrer do |click|
          click.referrer.present? ? truncate(click.referrer, length: 25) : "Direct"
        end
        column :created_at do |click|
          span "⏱️", class: "mr-1"
          time_ago_in_words(click.created_at) + " ago"
        end
      end
    end
  end
end
