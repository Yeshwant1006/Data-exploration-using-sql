import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_excel('file path')

df['ncap_test'] = pd.to_numeric(df['ncap_test'], errors='coerce')
df = df[df['ncap_test'].between(1, 5)]

df['ncap_stars'] = df['ncap_test'].apply(lambda x: '★' * int(x))

plt.figure(figsize=(8, 6))
sns.barplot(data=df, y='company_name', x='ncap_test', palette='coolwarm', orient='h')

plt.title('NCAP Rating Comparison Across Companies', fontsize=16)
plt.xlabel('NCAP Rating (Stars)', fontsize=12)
plt.ylabel('Companies', fontsize=12)

plt.xticks(fontsize=8)
plt.yticks(fontsize=8)

plt.tight_layout()

plt.show()
