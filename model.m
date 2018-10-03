function [ result ] = model( ~ )
%读取数据
clear,clc
for i=1:5
P1rgb{i}=imread(['picture2\',num2str(i),'.png']);
P1gray{i}=rgb2gray(P1rgb{i});%将读取的图片灰度化
P1log{i}=im2bw(P1gray{i},graythresh(P1gray{i}));%使用阈值变换法把灰度图像转换成二值图像
end
%数据初始化
[a,b]=size(P1gray{1});%获取矩阵的行数和列数
num=0;
blank=2;%这里还需要细化
n=length(P1gray);%图片张数
disp(P1gray{1}(:,1))
%==========================
%找最左和最右
for i=[1:blank-1,blank+1:n] %跳过空白的
    left(i)=sum(double(P1gray{i}(:,1)));%第一列的求和，用以找最左列
    right(i)=sum(double(P1gray{i}(:,b)));%最后一列求和，用以找最右列
end
[temp,left0]=max(left);%left0为最左列
[temp,right0]=max(right);%right0为最右列

number(1)=left0;
%==========================
%求欧式距离矩阵
p0=zeros(n,n);
p1=zeros(n,n);
for i=1:n
    for j=1:n
        p0(i,j)=sqrt(sum((double(P1gray{i}(:,b))-double(P1gray{j}(:,1))).^2));%求欧式距离
    end
end
p1=p0;
MAX=max(max(p0))+1;
p1(:,right0)=MAX;%剔除最右列(使其最大)，因为最右列会和截取的logo拼起来
p1(:,blank)=MAX;%剔除空白列

%第一次拼logo
for i=1:n-3 %先不管最右列和空白列，所以少2（从n-1到n-3）
   p1(:,number(i))=MAX; 
  [temp,number(i+1)]=min(p1(number(i),:)); 
end
result=P1gray{number(1)};
for i=2:n-2
    result=[result,P1gray{number(i)}];
end

%补上最右和最右的空白
result=[result,P1gray{right0},P1gray{blank}];
figure(3)
imshow(result)
end
