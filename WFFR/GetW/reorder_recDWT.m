function [new_order,wavespecs]=reorder_recDWT(wavespecsR,wavespecsC);
%%% [new_order,wavespecs]=reorder_recDWT(wavespecsR,wavespecsC);
%%%  Reorder wavelet coefficients from rectangular 2D-DWT, by applying
%%%     wavespecsR transform to the rows, and then wavespecsC to the column
%%% Output: index = new order of wavelet coefficients
%%%         wavespecs = new wavespecs, with number of wavelet coefficients
%%%         per level (Kj)

KjR=wavespecsR.Kj;
KjC=wavespecsC.Kj;

KR=sum(KjR);
KC=sum(KjC);
JR=length(KjR);
JC=length(KjC);
K=KR*KC;

%%% form matrix with indices after applying DWT to rows then columns;
index=reshape(1:K,KC,KR);
new_order=NaN(1,K);

Jnew=JC*JR;
Kj_new=NaN(1,Jnew);
jnew=0;
inew=0;
iR=0;
for (jR=1:JR)
    iC=0;
    iR2=iR+KjR(jR);
    for (jC=1:JC)
      jnew=jnew+1;
      iC2=iC+KjC(jC);
      Kj_new(jnew)=KjC(jC)*KjR(jR);
      inew2=inew+Kj_new(jnew);
      new_order((inew+1):(inew2))=reshape(index((iC+1):iC2,(iR+1):iR2),1,Kj_new(jnew));
      inew=inew2;
      iC=iC2;
    end;
    iR=iR2;
end;

wavespecs=wavespecsR;
wavespecs.Kj=Kj_new;
wavespecs.K=sum(Kj_new);
wavespecs.J=length(Kj_new);

