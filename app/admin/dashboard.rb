ActiveAdmin.register_page "Dashboard" do
  content title: "Admin Dashboard" do
    columns do
      # -------------------
      # Column 1: Top URLs
      # -------------------
      column do
        panel "Top 10 URLs by Clicks", class: "bg-gradient-to-r from-purple-400 via-pink-400 to-red-400 text-white rounded-xl shadow-xl p-6 mb-6 hover:scale-105 transform transition" do
          table_for Url.order(clicks: :desc).limit(10), class: "min-w-full divide-y divide-white/50" do
            column(:slug) { |url| span url.slug, class: "font-bold" }
            column(:original_url) { |url| link_to url.original_url, url.original_url, target: "_blank", class: "underline hover:text-yellow-200" }
            column(:clicks) { |url| span url.clicks, class: "font-semibold" }
            column(:expires_at) { |url| url.expires_at ? url.expires_at.strftime("%b %d, %Y") : "Never" }
          end
        end
      end

      # -------------------
      # Column 2: Charts & Referrers
      # -------------------
      column do
        panel "Clicks Per Day (Last 30 Days)", class: "bg-gradient-to-r from-green-400 via-teal-400 to-blue-400 text-white rounded-xl shadow-xl p-6 mb-6 hover:scale-105 transform transition" do
          div class: "p-2 bg-white/20 rounded-lg" do
            line_chart Click.group_by_day(:created_at, last: 30).count, library: { backgroundColor: "transparent" }
          end
        end

        panel "Top Referrers (Last 30 Days)", class: "bg-gradient-to-r from-yellow-400 via-orange-400 to-red-400 text-white rounded-xl shadow-xl p-6 mb-6 hover:scale-105 transform transition" do
          div class: "p-2 bg-white/20 rounded-lg" do
            pie_chart Click.where("created_at >= ?", 30.days.ago)
                           .group("COALESCE(referrer, 'Direct')")
                           .order("count_all DESC")
                           .limit(10)
                           .count, library: { backgroundColor: "transparent" }
          end
        end
      end
    end

    # -------------------
    # Recent Clicks Table
    # -------------------
    panel "Recent Clicks", class: "bg-gradient-to-r from-indigo-400 via-purple-400 to-pink-400 text-white rounded-xl shadow-xl p-6 hover:scale-105 transform transition" do
      table_for Click.order(created_at: :desc).limit(20), class: "min-w-full divide-y divide-white/50" do
        column :url do |click|
          link_to click.url.slug, admin_url_path(click.url), class: "text-blue-200 hover:text-yellow-300 font-semibold"
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
