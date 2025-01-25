import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_excel('file path')

model_sales = df.groupby('model_type')['no_of_units_sold_in_FY24'].sum().reset_index()

model_sales = model_sales.sort_values('no_of_units_sold_in_FY24', ascending=False)

plt.figure(figsize=(10, 5))
sns.barplot(x='model_type', y='no_of_units_sold_in_FY24', data=model_sales, palette='Set1')

plt.title('Count of Model Types by Number of Units Sold in FY24', fontsize=12)
plt.xlabel('Model Type', fontsize=10)
plt.ylabel('Number of Units Sold', fontsize=10)

plt.xticks(rotation=90, fontsize=8)
plt.yticks(fontsize=8)

plt.tight_layout()

plt.show()
