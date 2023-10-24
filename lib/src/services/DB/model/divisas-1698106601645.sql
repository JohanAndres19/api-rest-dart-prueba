
CREATE TABLE Divisa
(
  IdDivisa   varchar(3)  NOT NULL,
  PaisEmisor varchar(30) NOT NULL,
  Simbolo    varchar(2) ,
  PRIMARY KEY (IdDivisa)
);

CREATE TABLE TasaDeCambio
(
  IdDivisaAPKFK varchar(3)        NOT NULL,
  IdDivisaBPKFK varchar(3)        NOT NULL,
  ValorCambio   double precision  NOT NULL,
  PRIMARY KEY (IdDivisaAPKFK, IdDivisaBPKFK)
);

ALTER TABLE TasaDeCambio
  ADD CONSTRAINT FK_Divisa_TO_TasaDeCambio
    FOREIGN KEY (IdDivisaAPKFK)
    REFERENCES Divisa (IdDivisa);

ALTER TABLE TasaDeCambio
  ADD CONSTRAINT FK_Divisa_TO_TasaDeCambio1
    FOREIGN KEY (IdDivisaBPKFK)
    REFERENCES Divisa (IdDivisa);
