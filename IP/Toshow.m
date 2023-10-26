% IP Lab1 zad2
bs = [1,0.8,1,1.5,0.6] % Startowa matryca b od b0 do b4
s = 200; % Ilość losowych wartości u
u = rand(s,1) % Matryca losowych wartości u
y0 =(bs(1)-bs(2)*u)./(bs(3)-bs(4)*u+bs(5)*u.^2) % Wyliczenie y0 
y0max = max(y0) % Początkowe największe y0
yi = y0max % Ustawienie y0 jako yi dla zerowej iteracji
ynew = 0; % startowe ynew żeby uniknąć nadpisania w pierwszej iteracji
errorcond = false; % Zmienna boolowska do decyzji wyświetlenia rezultatów
Nmax = 1000; % maksymalna ilość iteracji

for i=1:Nmax
    % Sprawdzamy czy ynew jest lepsze od poprzedniej,
    % jeśli tak nadpisujemy
    if ynew > yi
        yi = ynew;
    end
    % Losujemy nową wartość kroku oraz wyliczamy nowe losowe wartości b
    krok = rand;
    bnew = bs + (krok*rand(5,1)' - 0.5*krok);
    % Nadpisujemy bs pod następną iteracją
    bs = bnew;
    % Wyliczamy matrycę y dla nowych wartości b
    ynew = (bnew(1)-bnew(2)*u)./(bnew(3)-bnew(4)*u+bnew(5)*u.^2);
    % Wybieramy najlepszą wartość
    ynew = max(ynew);
    % Sprawdzamy warunek stopu względem błędu
    if (y0max-ynew) < 1e-6
        errorcond = true;
        break;
    end
end

% Wyświetlenie rezultatów
i
if errorcond == true
    ynew
else
    yi
end
bnew
