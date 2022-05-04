
-- Test ReportModalita
CALL ReportModalita ('0eee');


DROP PROCEDURE IF EXISTS ReportModalita;

delimiter $$

create procedure ReportModalita (in _codFiscale varchar(255))
begin

declare numAccessi int(11) default 0;
declare numAccessiP int(11) default 0;
declare spaziAll bool default false;
declare numeroSale int(11) default 0;
declare numAccessipiu int(11) default 0;
declare numAccessipiuP int(11) default 0;

set @modalita = (
					select
						c.CodiceModalita
                    from
						contratto c
					where
						c.CodiceCliente = _codFiscale );
                        
set @tipologia = (
					select
						m.Tipologia
                    from
						modalita m
					where
						m.CodiceModalita = @modalita );
                        
select
	sum(a.MaxNumeroAccessiCentro) into numAccessi
from
	accessibile a
where
	a.CodiceModalita = @modalita;

select
	sum(c1.MaxNumeroAccessi) into numAccessiP
from
	consente1 c1
where
	c1.CodiceModalita = @modalita;
    
set @centro = (
				select
					count(distinct a.CodiceCentro)
				from
					accessibile a
				where
					a.CodiceModalita = @modalita );
            
set @accessieffettivi = (
						select
							count(*)/Count(distinct Month(a.Data))
						from
							accesso a
						where
							a.CodiceCliente = _codFiscale
                            and a.Piscina = 0
						);

set @accessieffettiviP = (
						select
							count(*)/Count(distinct month(a.Data))
						from
							accesso a
						where
							a.CodiceCliente = _codFiscale
                            and a.Piscina = 1
						group by
							month(a.Data));

set numeroSale = (
				select
					count(*)
				from
					consente1 c1
				where
					c1.CodiceModalita = @modalita );
    
select
	m.SpaziAllestibili into spaziAll
from
	modalita m
where
	m.CodiceModalita = @modalita;


if @tipologia = 'Silver' then
	set numAccessipiu = @accessieffettivi - 12;
    set numAccessipiuP = @accessieffetiviP;
	set numeroSale = numeroSale - 4*@centro;
else if @tipologia = 'Gold' then
	set numAccessipiu = @accessieffettivi - 16;
    set numAccessipiuP = @accessieffettiviP - 4;
    set numeroSale = numeroSale - 5*@centro;
else if @tipologia = 'Platinum' then
	set numAccessipiu = @accessieffetivi - 20;
    set numAccessipiuP = @accessieffetiviP - 8;
    set numeroSale = numeroSale - 6*@centro;
end if;
end if;
end if;

select
	numAccessipiu, numAccessipiu*4 as CostoAccessi,
    numAccessipiuP, numAccessipiuP*6 as CostoAccessiPiscina,
    numeroSale, spaziAll;

end $$

    
	