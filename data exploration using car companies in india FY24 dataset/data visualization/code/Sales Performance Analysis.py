import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_excel('file path')

sales_data = df[['model_name', 'no_of_units_sold_in_FY24']].groupby('model_name').sum().reset_index()

sales_data_sorted = sales_data.sort_values(by='no_of_units_sold_in_FY24', ascending=False)

plt.figure(figsize=(20, 25))
sns.barplot(x='no_of_units_sold_in_FY24', y='model_name', data=sales_data_sorted, palette='cividis')

plt.title('Sales Performance of Car Models in FY24', fontsize=26)
plt.xlabel('Number of Units Sold in FY24', fontsize=24)
plt.ylabel('Car Model', fontsize=24)
plt.xticks(fontsize=16)
plt.yticks(fontsize=16)

plt.tight_layout()
plt.show()
