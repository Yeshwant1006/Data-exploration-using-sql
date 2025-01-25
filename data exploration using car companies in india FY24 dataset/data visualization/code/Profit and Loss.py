import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

df_grouped = df.groupby('model_name').agg({'profit_by_model': 'sum', 'loss_by_model': 'sum'}).reset_index()

df_grouped = df_grouped.sort_values(by='profit_by_model', ascending=False)

df_grouped.set_index('model_name', inplace=True)

plt.figure(figsize=(16, 8))
plt.fill_between(df_grouped.index, df_grouped['profit_by_model'], color='green', alpha=0.6, label='Profit')
plt.fill_between(df_grouped.index, df_grouped['loss_by_model'], color='red', alpha=0.6, label='Loss')

plt.title('Profit and Loss Distribution across Car Models in FY24', fontsize=16)
plt.xlabel('Car Model', fontsize=12)
plt.ylabel('Amount (in million or specified currency)', fontsize=12)
plt.xticks(rotation=90, fontsize=10)
plt.yticks(fontsize=10)

plt.legend(fontsize='10', loc='upper right', labelspacing=0.1)

plt.tight_layout()
plt.show()
