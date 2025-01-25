import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

model_sales = df.groupby('model_name')['no_of_units_sold_in_FY24'].sum()

model_sales = model_sales.sort_values(ascending=False)

plt.figure(figsize=(30, 20))
model_sales.plot(kind='bar', color='skyblue')

plt.title('Number of Units Sold by Model in FY24', fontsize=20)
plt.xlabel('Car Model', fontsize=16)
plt.ylabel('Number of Units Sold', fontsize=16)
plt.xticks(rotation=90, ha='right', fontsize=14)
plt.yticks(fontsize=14)
plt.tight_layout()

plt.show()
