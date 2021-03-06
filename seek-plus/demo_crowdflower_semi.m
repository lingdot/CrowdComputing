clear;
tic
load('L_wordnet.mat');
load('groundFitData.mat');
load('knowledgeMatrix.mat'); 
p1=0.05;p=0.75;
[N,M] = size(knowledgeMatrix);
proMatrix = zeros(N,M);
for i = 1:N
    for j = 1:M
        if knowledgeMatrix(i,j)>0 && i~=j
            proMatrix(i,j) = log(p/(1-p));
            proMatrix(j,i) = log(p1/(1-p1));
        end
    end
end
model = crowd_model(L_wordnet, groundFitData);
Ntask = model.Ntask;
labeledRatio = 0;
labeledNumber = round(Ntask*labeledRatio);
groundTruthFlag = [zeros(1,(Ntask-labeledNumber)),ones(1,labeledNumber)];
result_SEEK_lnr_norm = SEEK_lnr_norm_semi(model,proMatrix,groundTruthFlag)
result_MWK = MajorityWithKnowledge(model,knowledgeMatrix);
result_MWW = MajorityWithWeight(model);
toc