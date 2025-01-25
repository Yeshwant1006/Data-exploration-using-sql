import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_excel("file path")

sales_performance = df.groupby('company_name')['no_of_units_sold_in_FY24'].sum().reset_index()

sales_performance = sales_performance.sort_values('no_of_units_sold_in_FY24', ascending=False)

plt.figure(figsize=(8, 4))
sns.barplot(x='company_name', y='no_of_units_sold_in_FY24', data=sales_performance, palette='viridis')

plt.title('Sales Performance of Car Companies in FY24', fontsize=10)
plt.xlabel('Company Name', fontsize=9)
plt.ylabel('Number of Units Sold', fontsize=9)
plt.xticks(rotation=90, fontsize=8)
plt.yticks(fontsize=8)
plt.tight_layout()

plt.show()

