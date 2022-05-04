-- Con ridondanza
select
	p.Username, avg(p.VotazioneTot) as MediaVoto
from
	post p
where
	p.Risposta = true
group by
	p.Username
order by
	MediaVoto
limit
	3;
    
-- Aggiornamento Ridondanza
delimiter $$

create trigger AggiornaVoto after insert on votazione
for each row
begin

set @VTot = (
			select
				avg(v.Valutazione)
            from
				votazione v
			where
				v.UtenteRisposta = new.UtenteRisposta
                and v.TimeStamp = new.TimeStamp );
                
update post p
set p.ValutazioneTot = @VTot
where
	p.Username = new.UtenteRisposta
    and p.TimeStamp = new.TIMESTAMP;

end $$
    
-- Senza ridondanza
select
	v.UtenteRisposta, avg(v.Valutazione) as MediaVoto
from
	votazione v
group by
	v.UtenteRisposta
order by
	MediaVoto desc
limit
	3;


