# Recipes-IOS
Recipe App for Take Home Assignment


### Summary: Include screen shots or a video of your app highlighting its features
    
 <img src="https://github.com/user-attachments/assets/f13f575c-414e-4850-97b5-9c4d7441fec3" width="300" />
 <img src="https://github.com/user-attachments/assets/055c27a6-59ea-42ed-a7c5-3108a6b287a3" width="300" />
 <img src="https://github.com/user-attachments/assets/65ecbe2c-ea59-4ccf-a980-34392d1b35b8" width="300" />



### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

    I chose to prioritize code structure and maintainability without too much additional fluff -> 
    I value performance as long as issues are mimimal and easy to fix. 
    
    I also focused on applying the downloading and caching of images without affecting the performance of the UI. 
    
    

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

    I spent 5-6 hours on this project.
    
    1.5 hour - drawing up a plan deviding the project into core and additional features,
               seperating concerns and creating a list of errors and test cases for each
               feature/concern. Creating code structure
    
    1 hour - studying filemanager usage and in-memory caching as well improving my 
             knowledge of different kinds of ascynhronous processes. 
    
    1 hours - implementing fetching of recipe data and decoding, handling errors appropriately. 
    
    1.5 hours - Implementing caching, running test cases on caching. Improving error handling 
                in caching process for both fetching and saving images.
    
    1 hour - Building out the UI and adding search feature
    
    

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

    I considered precaching/loading images and using a loading screen, but instead opted to download/cache them when the image is needed. This means
    that it may take longer for certain images to load, but the recipes list page is much quicker and much more responsive. It is also more scalable 
    for much larger lists of recipes.
    
    I focused on the core use case without creating alot of extra features. I kept the UI simple
    and focused on minimizing errors and trying to make the loading of the recipes as clean 
    and smooth as possible. 
    
    Using on disk storage for both large and small images could potentially lead to a slighly bulkier storage,
    but makes the UI experience much more responsive and smooth. 
    

    
### Weakest Part of the Project: What do you think is the weakest part of your project?
    
    Minimal UI and lack of additional features. 
    I am not an expert in writing unit tests. 
    Search feature does not handle clearing of filter without reload of list
    
### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

    If had more time to work on this, I would have considered expiration and management of image files on the disk to optimize storage
    
    I believe that what I have created is perfectly set up for a feature that allows users to download and save favorite recipes for offline use. 

    Even if I don't advance in the interviewing process, I learned way more about software engineering doing this assignment than any Leetcode question 
    I have ever done. So, thank you. 
    
    
    

