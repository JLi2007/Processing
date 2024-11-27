// Download the current instance of the file to data/output/result.png
void saveFile(){
    // save the new instance to data/output. The old instance is automatically deleted by processing.
    save("data/output/result.png");
}

// Using imgur api to generate a link to your image (data/output/result.png)
void shareFile(){
    // the imgur image uploading endpoint
    String endpoint = "https://api.imgur.com/3/image";
    // imgur clientID API key - normally shouldn't be exposed... (if you aren't Mr Waters don't use this please 😂)
    String clientID = "5a40d6e685c2c70";
    
    try{
        // load image into a byte array
        byte[] imageBytes = loadBytes("data/output/result.png");
        // encode the bytes to a set a characters so we can send it to imgur api endpoint
        String encodedImage = java.util.Base64.getEncoder().encodeToString(imageBytes);
        
        // initialize the post request and add the required header for the api call to work
        PostRequest post = new PostRequest(endpoint);
        post.addHeader("Authorization", "Client-ID " + clientID);

        // add the image, along with a title and description to the imgur post request
        post.addData("image", encodedImage);
        if(postTitle != null){
            post.addData("title", postTitle);
        }else{
            post.addData("title", "Piximatic Result Image");
        }
        if(postDescription != null){
            post.addData("description", postDescription);
        }

        // send the request
        post.send();

        // parse the response into a JSON object
        response = parseJSONObject(post.getContent());
        // enters the data key and selects the link key
        imgurLink = response.getJSONObject("data").getString("link");
        // print it to the terminal for the user
        println("Here is your image: " + imgurLink);
    }
    catch(NullPointerException e){ //catch the error
        println("make sure you save an image first!");
    }
}

// Opens the link in search app
void clickLink(String link){
    link(link);
}