Recommendation System (item recommendation): Item-Based Collaborative Filtering
===============

Item-based collaborative filtering is also called item-item collaborative filtering. It is a type of recommendation system algorithm that uses item similarity to make product recommendations.


Item-based collaborative filtering makes recommendations based on user-product interactions in the past. The assumption behind the algorithm is that users like similar products and dislike similar products, so they give similar ratings to similar products.

Item-based collaborative filtering algorithm usually has the following steps:
  - Calculate item similarity scores based on all the user ratings.
  - Identify the top n items that are most similar to the item of interest.
  - Calculate the weighted average score for the most similar items by the user.
  - Rank items based on the score and pick top n items to recommend.


![recommendation-image-768x828](https://user-images.githubusercontent.com/72437756/232766310-3631361a-7ed7-49ea-8dc7-1a84dcb7086f.png)

This graph illustrates how item-based collaborative filtering works using a simplified example.
--------------

  - Ms. Blond likes apples, watermelons, and pineapples.
  - Ms. Black likes watermelons and pineapples.
  - Ms. Purple likes watermelons and grapes. Because watermelons and pineapples are liked by the same persons, they are considered similar items.
  - Since Ms. Purple likes watermelons and Ms. Purple has not been exposed to pineapples yet, the recommendation system recommends pineapples to Ms. purple.


NOTE:
--------------
THIS CODE IS JUST FOR THE PURPOSE OF DEMO.
You can add similarity_scores score in caching or nosql db instead of calculating everytime and recalculate similarity_scores based on traffic you have and reinsert/update the record. 
I had added DB structure just for reference. You have to add data according to the image as shown above and run the code you will get the result.


Above example reference taken from site [grabngoinfo](https://grabngoinfo.com/recommendation-system-item-based-collaborative-filtering/)
