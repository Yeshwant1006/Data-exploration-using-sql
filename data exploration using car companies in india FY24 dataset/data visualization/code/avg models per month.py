import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

avg_models_per_company = df.groupby('company_name')['avg_models_per_month'].mean()

plt.figure(figsize=(12, 6))

avg_models_per_company.plot(kind='bar', color='skyblue', edgecolor='black')

plt.xlabel('Company Name', fontsize=14)
plt.ylabel('Average Models per Month', fontsize=14)
plt.title('Average Models per Month Across Companies', fontsize=16)

plt.xticks(fontsize=10, rotation=90)
plt.yticks(fontsize=10)

plt.tight_layout()
plt.show()
