function [ result ] = model( ~ )
%��ȡ����
clear,clc
for i=1:5
P1rgb{i}=imread(['picture2\',num2str(i),'.png']);
P1gray{i}=rgb2gray(P1rgb{i});%����ȡ��ͼƬ�ҶȻ�
P1log{i}=im2bw(P1gray{i},graythresh(P1gray{i}));%ʹ����ֵ�任���ѻҶ�ͼ��ת���ɶ�ֵͼ��
end
%���ݳ�ʼ��
[a,b]=size(P1gray{1});%��ȡ���������������
num=0;
blank=2;%���ﻹ��Ҫϸ��
n=length(P1gray);%ͼƬ����
disp(P1gray{1}(:,1))
%==========================
%�����������
for i=[1:blank-1,blank+1:n] %�����հ׵�
    left(i)=sum(double(P1gray{i}(:,1)));%��һ�е���ͣ�������������
    right(i)=sum(double(P1gray{i}(:,b)));%���һ����ͣ�������������
end
[temp,left0]=max(left);%left0Ϊ������
[temp,right0]=max(right);%right0Ϊ������

number(1)=left0;
%==========================
%��ŷʽ�������
p0=zeros(n,n);
p1=zeros(n,n);
for i=1:n
    for j=1:n
        p0(i,j)=sqrt(sum((double(P1gray{i}(:,b))-double(P1gray{j}(:,1))).^2));%��ŷʽ����
    end
end
p1=p0;
MAX=max(max(p0))+1;
p1(:,right0)=MAX;%�޳�������(ʹ�����)����Ϊ�����л�ͽ�ȡ��logoƴ����
p1(:,blank)=MAX;%�޳��հ���

%��һ��ƴlogo
for i=1:n-3 %�Ȳ��������кͿհ��У�������2����n-1��n-3��
   p1(:,number(i))=MAX; 
  [temp,number(i+1)]=min(p1(number(i),:)); 
end
result=P1gray{number(1)};
for i=2:n-2
    result=[result,P1gray{number(i)}];
end

%�������Һ����ҵĿհ�
result=[result,P1gray{right0},P1gray{blank}];
figure(3)
imshow(result)
end
