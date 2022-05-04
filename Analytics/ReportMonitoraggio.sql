CALL ReportMonitoraggio('0aaa', '2015-07-02');
CALL ReportMonitoraggio('0bbb', '2015-07-02');

CALL ModificaScheda ('0bbb');

DROP PROCEDURE IF EXISTS ReportMonitoraggio;

delimiter $$

create table if not exists RMonitoraggio like Monitoraggio$$

alter table RMonitoraggio
	  drop column GiornoSettimana,
    drop column Accesso,
    drop column Centro $$

create procedure ReportMonitoraggio (in _codFiscale VARchar(45), in _dataAnalisi date)
begin

declare finito integer default 0;
declare a int(11) default 0;
declare c int(11) default 0;
declare d int(11) default 0;
declare e int(11) default 0;
declare f int(11) default 0;
declare h int(11) default 0;



declare Monitor cursor for
select
    avg(m.RecuperoEffettivo) as RecEff, avg(m.SforzoFisicoEffettivo) as SforFisEff,
    avg(m.QuantitaEffettiva) as QuantEff, avg(m.EnergiaEffettiva) as EnerEff, avg(m.DurataEffettiva) as DurEff,
    avg(m.TempoRecuperoEffettivo) as RecEff
from
    monitoraggio m
where
	m.CodiceFiscale = _codFiscale
	and m.DataIngresso > _dataAnalisi ;
    
declare continue handler for not found set finito = 1;

open Monitor;

scan : loop

	fetch Monitor into a, b, c, d, e, f, g;
	if finito = 1 then
		leave scan;
	end if;
	
    
    insert into RMonitoraggio values (a, b, c, d, e, f, g);
    
    end loop;

close Monitor;

select
	*
from
	workoutroutine w
    natural join
    rmonitoraggio rm;
    
end $$


DROP PROCEDURE IF EXISTS ModificaScheda $$ 

create procedure ModificaScheda (in _cf VARCHAR(45))
begin

update
	workoutroutine w
    natural join
    (
		select
			sc.CodiceScheda
		from
			schedaallenamento sc
		where
			sc.CodiceCliente = _cf
			and sc.DataInizio >= all(
										select
											sc2.DataInizio
										from
											schedaallenamento sc2
										where
											sc2.CodiceCliente = _cf)) AS D
	natural join
    rmonitoraggio rm
set w.Serie = w.Serie + ((rm.SerieEffettive - w.Serie)/2),
	w.Ripetizioni = w.Ripetizioni + ((rm.RipetizioniEffettive - w.Ripetizioni)/2),
    w.Tempo = w.Tempo + ((rm.TempoEffettivo - w.Tempo)/2),
    w.Peso = w.Peso + ((rm.PesoEffettivo - w.Peso)/2),
    w.Intensita = w.Intensita + ((rm.IntensitaEffettiva - w.Intensita)/2),
    w.TempoRecupero = w.TempoRecupero + ((rm.TempoRecuperoEffettivo - w.TempoRecupero)/2);
    
select
	'WorkOut settimanale modificato.';
    
end $$
    
	
									