ActiveAdmin.register_page "Dashboard" do
  content title: "Admin Dashboard" do
    columns do
      # -------------------
      # Column 1: Top URLs
      # -------------------
      column do
        panel "Top 10 URLs by Clicks" do
          table_for Url.order(clicks: :desc).limit(10) do
            column :slug
            column :original_url
            column :clicks
            column :expires_at
          end
        end
      end

      # -------------------
      # Column 2: Clicks per Day
      # -------------------
      column do
        panel "Clicks Per Day (Last 30 Days)" do
          div do
            line_chart Click.group_by_day(:created_at, last: 30).count
          end
        end

        # -------------------
        # Top Referrers Panel
        # -------------------
        panel "Top Referrers (Last 30 Days)" do
          div do
            pie_chart Click.where("created_at >= ?", 30.days.ago)
                           .group("COALESCE(referrer, 'Direct')")
                           .order("count_all DESC")
                           .limit(10)
                           .count
          end
        end
      end
    end

# -------------------
# Recent Clicks Table
# -------------------
panel "Recent Clicks" do
  table_for Click.order(created_at: :desc).limit(20) do
    column :url do |click|
      if click.url
        link_to click.url.slug, admin_url_path(click.url)
      else
        "URL deleted"
      end
    end
    column :ip_address
    column :referrer
    column :created_at
  end
end
  end
end
