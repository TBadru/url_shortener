ActiveAdmin.register_page "Dashboard" do
  content title: "Admin Dashboard" do
    div class: "aa-wrapper" do
      columns do
        # Column 1: Top URLs
        column do
          panel "Top 10 URLs by Clicks", class: "aa-panel" do
            table_for Url.order(clicks: :desc).limit(10), class: "aa-table" do
              column(:slug)
              column(:original_url)
              column(:clicks)
              column(:expires_at)
            end
          end
        end

        # Column 2: Charts
        column do
          panel "Clicks Per Day (Last 30 Days)", class: "aa-panel" do
            div do
              line_chart Click.group_by_day(:created_at, last: 30).count
            end
          end

          panel "Top Referrers (Last 30 Days)", class: "aa-panel" do
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

      # Recent Clicks Table
      panel "Recent Clicks", class: "aa-panel" do
        table_for Click.order(created_at: :desc).limit(20), class: "aa-table" do
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
end
