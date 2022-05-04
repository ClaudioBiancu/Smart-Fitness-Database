DROP TRIGGER IF EXISTS BR_Calendario ;

delimiter $$

create trigger BR_Calendario before insert on Calendario
for each row
begin

declare hri int(11) default 0;
declare hrf int(11) default 0;
declare gg int(11) default 0;
declare tch char(255) default '';
declare corso char(255) default '';
declare centro char(255) default '';
declare trovato int(11) default 0;

set gg = new.Giorno;

set hri = new.OrarioInizio;

set hrf = new.OrarioFine;

set corso = new.Corso;

set centro = (
			select
				c.CodiceCentro
			from
				corso c
			where
				c.Codice = corso );

set tch = (
			select
				c.Istruttore
			from
				corso c
			where
				c.Codice = corso );

set trovato = (
				select
					count(*)
                from
					turnazione t
				where
					t.Dipendente = tch
                    and t.Giorno = gg
                    and hri between t.OrarioInizio and t.OrarioFine
                    and hrf between t.OrarioInizio and t.OrarioFine );
                    
if trovato = 0 then
	signal sqlstate '45000'
    set message_text = 'Impossibile inserire il calendario perchè turno del dipendente non presente';
end if;

end $$

delimiter ;