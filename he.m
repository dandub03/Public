s = 200; % Ilość losowych wartości u 
 u = rand(s,1) % Matryca losowych wartości u 
 y0 =(bs(1)-bs(2)*u)./(bs(3)-bs(4)*u+bs(5)*u.^2) % Wyliczenie y0  
  
 krok = rand; 
 bnew = bs + (krok*rand(5,1)' - 0.5*krok); 
 ynew = (bnew(1)-bnew(2)*u)./(bnew(3)-bnew(4)*u+bnew(5)*u.^2); 
  
 Error=sum((y0-ynew).^2)/s; %Wyliczenie błędu (błąd średniokwadratowy) 
  
 Nmax = 10000; % maksymalna ilość iteracji 
  
 for i=1:Nmax 
  
     % Losujemy nową wartość kroku oraz wyliczamy nowe losowe wartości b 
     krok = rand; 
     bnew = bs + (krok*rand(5,1)' - 0.5*krok); 
     % Wyliczamy matrycę y dla nowych wartości b 
     ynew = (bnew(1)-bnew(2)*u)./(bnew(3)-bnew(4)*u+bnew(5)*u.^2); 
  
     NewError=sum((y0-ynew).^2)/s; %Wyliczenie nowego błędu 
  
     if Error > NewError 
         bs=bnew; 
         Error=NewError; 
     end 
  
     if Error < 1e-6 
         break; 
     end 
 end 
  
 i 
 plot(y0-ynew) 
 ylabel("Błąd: (y0 - ynew)"); 
 xlabel("Numer próbki")