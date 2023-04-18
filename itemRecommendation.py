import mysql.connector
import numpy as np
import pandas as pd

# Connect to the database
conn = mysql.connector.connect(user='{db_username}', password='{db_password}', host='{db_hostip}', port=6033,
                               database='{db_name}')
cursor = conn.cursor()

# Get all the `cart_id` values and item-item pairs
# %s i.e. 8 in this case is the current cart of user that we should not include in analysis as we are recommending on the current cart
query = "SELECT cart_id, type as product_type FROM items where cart_id != %s"
cursor.execute(query, (8,)) # 8 in this case is the current cart of user that we should not include in analysis as we are recommending on the current cart
data = cursor.fetchall()

# Create a pandas DataFrame
item_likes = pd.DataFrame(data, columns=["cart_id", "product_type"])

# Create a pivot table to get the item-item similarity scores
pivot = pd.pivot_table(item_likes, index='cart_id', columns='product_type', aggfunc=len, fill_value=0)

# Compute the cosine similarity scores between each pair of items
similarity_scores = pivot.T.dot(pivot)

# Normalize the similarity scores
norms = np.linalg.norm(pivot, axis=0)
similarity_scores = similarity_scores / norms
similarity_scores = similarity_scores / norms[:, None]

# Replace the diagonal values with 0, so that items are not recommended to themselves
# np.fill_diagonal(similarity_scores, 0)

# Replace the diagonal values with 0, so that items are not recommended to themselves
for i in range(similarity_scores.shape[0]):
    similarity_scores.iloc[i, i] = 0

"""
Note:
You can store this similarity_scores in nosql db or cache this.
This is totally depends on the architecture and traffic your system is having.
"""
    

"""
Output of similarity_scores is must be like this
product_type     apple  pineapple  watermelon
product_type
apple         0.000000   0.707107    0.707107
pineapple     0.707107   0.000000    1.000000
watermelon    0.707107   1.000000    0.000000
"""

def recommend_items(argument_similarity_scores, product_type, total_recommendations=2):
    if product_type not in argument_similarity_scores:
        return pd.Index([])
    argument_similarity_scores = argument_similarity_scores[product_type].sort_values(ascending=False)
    if argument_similarity_scores.iloc[0] <= 0:
        return pd.Index([])
    top_n = argument_similarity_scores.iloc[:total_recommendations].index
    return top_n


print(recommend_items(similarity_scores, 'watermelon', 1))
"""
Output of similarity_scores is must be like this
Index(['pineapple'], dtype='object', name='product_type')
"""
