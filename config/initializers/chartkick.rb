# config/initializers/chartkick.rb

Chartkick.options = {
  colors: [
    "#3B82F6", # blue-500
    "#8B5CF6", # violet-500
    "#10B981", # emerald-500
    "#F59E0B", # amber-500
    "#EF4444", # red-500
    "#EC4899", # pink-500
    "#6366F1", # indigo-500
    "#14B8A6", # teal-500
    "#84CC16", # lime-500
    "#0EA5E9", # sky-500
  ],
  library: {
    backgroundColor: "transparent",
    legend: {
      position: "bottom",
      labels: { fontSize: 13, color: "#4B5563" } # gray-700
    },
    title: { color: "#111827", fontSize: 16 }, # gray-900
    chartArea: { backgroundColor: "transparent" },
    hAxis: {
      textStyle: { color: "#6B7280" }, # gray-500
      gridlines: { color: "rgba(209,213,219,0.2)" }, # gray-300/20
    },
    vAxis: {
      textStyle: { color: "#6B7280" },
      gridlines: { color: "rgba(209,213,219,0.2)" },
    },
    tooltip: {
      textStyle: { color: "#111827" },
      showColorCode: true,
    },
  },
}
