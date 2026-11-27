// Executer depuis le dossier contenant les deux fichiers Scilab.
clear; clc;
// Le script retrouve ses fichiers meme si le dossier courant est different.
chdir(get_absolute_file_path("TP_02_Application_Etudiant.sce"));
exec("TP_02_Outils_EDO.sci",-1);

function z=f_test(t,y)
    z=1;
endfunction
[t,y,c]=integrer_edo(f_test,0,1,2,10,"euler");
if max(abs(y-(2+t)))>1d-12 then error("Test constant echoue"); end
mprintf("Test constant Euler : OK, cout=%d\n",c);

//---- Controle Q1 / Q2 : Euler, Heun, RK4 ----
methodes_test=["euler"  "heun" "rk4"];
couts_test=[1 2 4];  //evaluations de f par pas

//---Q1 : un pas pour y'=-2y, y0=1, h=0,1 ---
function z=f_lin(t,y)
    z=-2*y;
endfunction
attendu_q1=[0.8 0.82 0.8187333333333333];

for i=1:3
    methode=methodes_test(i);
    [t,y,c]=integrer_edo(f_lin,0,0.1,1,1,methode);
    if abs(y(2)-attendu_q1(i))>1d-12 then
        error("Controle Q1 echoue : "+methode);
    end
    if c<>couts_test(i) then
        error("Cout Q1 incorrect : "+methode);
    end
    mprintf("Q1 %s : y1=%.12f, cout=%d : OK\n",methode,y(2),c);
end
//   Q2 : y'=1, y(0)=2 sur [0,1], N=10 (f_test est defini plus haut)   
for i=1:3
    methode=methodes_test(i);
    [t,y,c]=integrer_edo(f_test,0,1,2,10,methode);
    if max(abs(y-(2+t)))>1d-12 then
        error("Test constant echoue :"+methode);
    end
    if size(t,"*")<>11 | size(y,"*")<>11 then
        error("Nombre de valeur incorrect : : "+methode);
    end
    if abs(t(1))>1d-12 | abs(t($)-1)>1d-12 then 
        error("Maillage incorrect : "+methode);
    end
    if c<>10*couts_test(i) then
        error ("Cout incorrect : "+methode);
    end
    mprintf("Q2 constant %s : OK, cout=%d\n",methode,c);
end
//---Q2 : controle du temps intermediaire, y'=t, y(0)=0, un pas h=0,2---
function z=f_temps(t,y)
        z=t;
    endfunction
    attendu_temps=[0 0.02 0.02];
    for i=1:3
        methode=methodes_test(i);
        [t,y,c]=integrer_edo(f_temps,0,0.2,0,1,methode);
        
        if abs(y($)-attendu_temps(i))>1d-12 then
            error("Test temps echoue : "+methode);
        end
        mprintf("Q2 temps %s : y1=%.4f : OK\n",methode,y($));
    end
// --- Fin des controles Q1 / Q2 ---    
function z=f_decay(t,y)
    z=-15*y;
endfunction
Ns=[5 10 20 40 80 160 320];
methodes=["euler","heun","rk4"]; 
resultats=[]; // methode_id : 1=euler, 2=heun, 3=rk4 (ordre fixe).
// Conserver cet ordre en ajoutant les methodes.
csvWrite([1;2;3],"TP2_methodes.csv",";",".","%d", ..
    "methode_id (1=euler, 2=heun, 3=rk4)");
for m=1:size(methodes,"*")
    E=zeros(1,size(Ns,"*")); cout=E;
    for j=1:size(Ns,"*")
        [t,y,c]=integrer_edo(f_decay,0,1,1,Ns(j),methodes(m));
        E(j)=max(abs(y-exp(-15*t)));
        cout(j)=c;
    end
    for j=1:size(Ns,"*")
        p=%nan;
        if j<size(Ns,"*") then p=ordre_edo(E(j),E(j+1)); end
        resultats=[resultats; m Ns(j) 1/Ns(j) E(j) cout(j) p];
    end
end
csvWrite(resultats,"TP2_convergence.csv",";",".","%.12e", ..
    "methode_id;N;h;Emax;nfev;p_vers_ligne_suivante");
disp(resultats);
//---- Figure Q4 : erreur en fonction de h (echelles log-log)----
Nn=size(Ns,"*");
Hm=matrix(resultats(:,3),Nn,3);
Em=matrix(resultats(:,4),Nn,3);
scf(1); clf();
plot2d(Hm,Em,style=[2,3,5],leg="Euler@Heun@RK4",logflag="ll");
plot2d(Hm(1,:),Em(1,:),style=-9,logflag="ll");
xtitle("Convergence sur y''=-15y (ronds:N=5, instable)","h (temps adimensionne)","E_N = erreur max aux noeuds");
xs2png(gcf(),"fig_convergence.png");
// Des NaN dans Emax signalent TODO A non termine.
// ---- Q5 : budget egal, 400 evaluations def ----
Nb=[400 200 100];
Eb=zeros(1,3);
for m=1:3
    [t,y,c]=integrer_edo(f_decay,0,1,1,Nb(m),methodes(m));
    Eb(m)=max(abs(y-exp(-15*t)));
    mprintf("%s : N=%d, nfev=%d, erreur=%.3e\n",methodes(m),Nb(m),c,Eb(m));
end
// --- Q6 : stabilité, y'=-15y ---
function R=facteur_R(z,nom)
    select nom
    case "euler" then
        R=1+z;
    case "heun" then
        R=1+z+z^2/2;
    case "rk4" then
        R=1+z+z^2/2+z^3/6+z^4/24;
    end
endfunction

hq=[0.2 0.1];
scf(2); clf();
for i=1:2
    Nq=round(1/hq(i));
    Yq=zeros(Nq+1,3);
    zq=-15*hq(i);
    for m=1:3
        [t,y,c]=integrer_edo(f_decay,0,1,1,Nq,methodes(m));
        Yq(:,m)=y';
        R=facteur_R(zq,methodes(m));
        mprintf("h=%.1f z=%.1f %s : R=%.6f |R|=%.6f ; y(1)=%.4e\n",hq(i),zq,methodes(m),R,abs(R),y($));
    end
    subplot(1,2,i);
    plot2d(t',[exp(-15*t') Yq],style=[1,2,3,5],leg="exacte@Euler@Heun@RK4");
    xtitle("h = "+string(hq(i)),"t (adimensionne)","y");
end
xs2png(gcf(),"fig_stabilite.png");
// --- Q7 : Euler sur y'=-10y ---
function z=f_dec10(t,y)
    z=-10*y;
endfunction
for Nq=[4 6 20]
    [t,y,c]=integrer_edo(f_dec10,0,1,1,Nq,"euler");
    mprintf("N=%d, h=%.4f, R=%.4f, y(1)=%.4e, erreur max=%.3e\n",Nq,1/Nq,1-10/Nq,y($),max(abs(y-exp(-10*t))));
end

// ---- CSV final : diagnostic stable/instable et ordre interpretable ----
noms=["Euler","Heun","RK4"];
fd=mopen("TP2_convergence_complet.csv","wt");
mfprintf(fd,"methode;methode_id;N;h;z;modR;Emax;nfev;p_vers_ligne_suivante;stabilite;ordre_interpretable;diagnostic\n");
nl=size(resultats,"r");
for k=1:nl
    m=resultats(k,1);
    hk=resultats(k,3); Ek=resultats(k,4); pk=resultats(k,6);
    zk=-15*hk;
    mR=abs(facteur_R(zk,methodes(m)));
    if mR>1+1d-12 then
        stab="instable";
    elseif mR>=1-1d-12 then
        stab="limite";
    else
        stab="stable";
    end
    interpr="non";
    if k==nl then
        dg="derniere ligne : pas de ligne suivante (p=NaN normal)";
    elseif resultats(k+1,1)<>m then  dg="derniere ligne : pas de ligne suivante (p=NaN normal)";
    elseif mR>=1-1d-12 then
        dg="ligne courante non strictement amortie : ordre non interpretable";
    else
        mR2=abs(facteur_R(-15*resultats(k+1,3),methodes(m)));
        if mR2>=1-1d-12 then
            dg="ligne suivante non stable";
        elseif Ek<1d-13 | resultats(k+1,4)<1d-13 then
            dg="erreur dominee par l''arrondi";
        else
            interpr="oui";
            dg="deux regimes stables, erreurs au-dessus de l''arrondi";
        end
    end
    mfprintf(fd,"%s;%d;%d;%.12e;%.6f;%.12e;%.12e;%d;%.12e;%s;%s;%s\n", ..
        noms(m),m,resultats(k,2),hk,zk,mR,Ek,resultats(k,5),pk,stab,interpr,dg);
end
mclose(fd);
// Application thermique : un modele pedagogique, pas des mesures.
Cth=1000; H=10; P=100; Ta=20; theta0=20;
function z=f_therm(t,theta)
    z=(P-H*(theta-Ta))/Cth;
endfunction
function theta=theta_ref(t,Hval)
    eq=Ta+P/Hval;
    theta=eq+(theta0-eq)*exp(-Hval*t/Cth);
endfunction
// ---- Q8 : valeurs de reference (comparaison avec le calcul a la main) ----
mprintf("theta_inf = %.4f degC ; tau = %.1f s\n" , Ta+P/H, Cth/H);
mprintf("theta_ref(100) = %.4f\n" , theta_ref(100,H));
mprintf("theta_ref(250) = %.4f\n" , theta_ref(250,H));
mprintf("theta_ref(1000) = %.5f\n" , theta_ref(1000,H));
// ---- Q9 : choix du pas, horizon 1000 s ----
Nt=[100 10 4];
for i=1:3
    for m=1:3
        [t,y,c]=integrer_edo(f_therm,0,1000,theta0,Nt(i),methodes(m));
        Et=max(abs(y-theta_ref(t,H)));
        zt=-H*(1000/Nt(i))/Cth;
        mprintf("%s N=%d h=%g s z=%g : Emax=%.4e degC, nfev=%d\n",methodes(m),Nt(i),1000/Nt(i),zt,Et,c);
    end
end
// ---- Q10 : sensibilite a H, temps fixes ----
Tf=[0 100 500 1000];
for Hv=[8 12]
    ecart=theta_ref(Tf,Hv)-theta_ref(Tf,10);
    mprintf("H=%d : ecarts signes = %s ; max |ecart| = %.4f degC\n",Hv, strcat(string(ecart)," "),max(abs(ecart)));
end
// Conseils graphiques dans l'interface Scilab :
// plot2d(h,E,logflag="ll") pour un tableau d'erreurs positives.
// Ajouter titres, legendes, unites et identifier les calculs instables.
