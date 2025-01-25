import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

fuel_type_counts = df['fuel_type'].value_counts()

colors = ['#ff9999', '#66b3ff', '#99ff99', '#ffcc99', '#ff6666', '#c2c2f0', '#ffb3e6']

plt.figure(figsize=(10, 10))
plt.pie(fuel_type_counts,
        labels=fuel_type_counts.index,
        autopct='%1.1f%%',
        startangle=90,
        colors=colors,
        labeldistance=1.01)

plt.title('Fuel Type Distribution Across Car Companies', fontsize=16)

plt.setp(plt.gca().texts, fontsize=8)

plt.axis('equal')
plt.show()
