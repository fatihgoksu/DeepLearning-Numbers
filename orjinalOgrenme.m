close all;
clear all;
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet', ...
    'nndemos','nndatasets','DigitDataset','FitreKarsilastirma');
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

numTrainingFiles = 750;%750
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');

layers = [ ...
    imageInputLayer([28 28 1],'Name','input')
    convolution2dLayer(5,20,'Padding',3)
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'MaxEpochs',20,...
    'InitialLearnRate',1e-4, ...
    'Verbose',0, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);
YPred = classify(net,imdsTest);
YTest = imdsTest.Labels;
accuracy = sum(YPred == YTest)/numel(YTest);
convolutionFiltre=net.Layers(2).Weights;

I = imread('image10000.png');
[label,ERR] = classify(net,I); 
figure;
subplot(2,1,1);
imshow(I); 
title(char(label))
subplot(2,1,2); 
imshow(I); 
title(ERR)