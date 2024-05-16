function [] = SaveVideo(dir, batch, imageDir, numImages)
    % Converts the saved series of images to a video.

    video = VideoWriter(dir + batch + imageDir, 'Uncompressed AVI'); %create the video object
    video.FrameRate = 10;
    open(video); %open the file for writing
    for index=1:numImages %where N is the number of images
      i_image = dir + batch + "_" + index + imageDir + ".png";
      I = imread(i_image); %read the next image
      %I = imresize(I, [500, 500]);
      writeVideo(video,I); %write the image to file
      delete (i_image);
    end
    close(video); %close the file


end