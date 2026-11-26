//---- Controle Q1 / Q2 : Euler, Heun, RK$ ----
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
    if size(t,"")<>11 | size(y,"")<>11 then
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
