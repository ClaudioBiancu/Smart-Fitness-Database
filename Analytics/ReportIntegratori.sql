-- Test Procedure
CALL ReportScadenza(0);

CALL ReportVendite ( 2, '2015-06-06');

CALL ReportVendite (4, '2016-07-08');





drop table Promozioni;

create table Promozioni (
	ID integer not null,
    Promozione text,
    primary key (ID)
    )engine = InnoDB;
    
delimiter $$
    
create procedure ReportScadenza (in _codC int(11))
begin

select
	*
from(
	select
		if(@datas = m.DataScadenza,
			@rank := @rank,
            @rank := @rank + 1 + least(0, @datas := m.DataScadenza)) as ID,
		m.CodiceCentro,
		m.NomeIntegratore,
        m.DataScadenza
    from
		magazzino m,
        (select(@rank := 0)) as r
	where
		m.CodiceCentro = _codC
	order by
		m.DataScadenza) as D
	Natural join
	promozioni p;
    
end $$

drop procedure if exists ReportVendite $$

create procedure ReportVendite ( in _codC int(11), in _data date)
begin

select
 *
from(
select
	if(@diff = D.Diff,
		@rank = @rank,
        @rank = @rank + 1 + least(0, @diff := D.Diff)) as ID,
	D.NomeIntegratore,
    D.Diff
from
	(
	select
		M.NomeIntegratore, (M.QuantiAcquistati - N.QuantiVenduti) as Diff
    from
		(
        select
			ro.NomeIntegratore, sum(ro.Quantita) as QuantiAcquistati
        from
			ordine o
			natural join
			riepilogoordine ro
		where
			o.CodiceCentro = _codC
            and o.DataConsegna >= _data
		group by
			ro.NomeIntegratore) as M
		natural join
        (
        select
			t.Nomeintegratore, sum(t.QuantitaAcquistata) as QuantiVenduti
        from
			transazione t
		where
			t.CodiceMagazzino = _codC
            and t.Data >= _data
		group by
			t.NomeIntegratore ) as N) as D,
		(select(@rank := 0)) as r
order by
	D.Diff ) as T
natural join
promozioni p;

    
end $$
