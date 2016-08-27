select distinct b.codacesso as EAN, b.seqproduto as ID_PRODUTO,
 c.familia as NOME, b.qtdembalagem as UDM,
 f.estqloja as ESTOQUE, e.precobasenormal as PRECO,
 round(f.cmultvlrnf + f.cmultipi - f.cmultcredicms + f.cmulticmsst +
 f.cmultdespnf + f.cmultdespforanf - f.cmultdctoforanf - 
 nvl(f.cmultcredpis, 0) - nvl(f.cmultcredcofins, 0),2) as CUSTO,
 (select sum(qtdsaidamedvenda) from mrl_custodia where dtaentradasaida between (select trunc(sysdate)-30 from dual) and (select trunc(sysdate)from dual)
group by seqproduto)as Movimento_reg ,a.profundidade, a.largura, a.altura 
 from map_famembalagem a
     inner join map_familia        c on c.seqfamilia = a.seqfamilia
     inner join map_prodcodigo     b on b.seqfamilia = c.seqfamilia
     inner join mrl_prodempseg     e on e.seqproduto = b.seqproduto 
     inner join mrl_produtoempresa f on f.seqproduto = e.seqproduto and f.nroempresa = e.nroempresa 
     inner join mrl_custodia       g on g.seqproduto = b.seqproduto
where  b.qtdembalagem = 1 and b.tipcodigo in ('E') and e.motivoprecogerado not in ('Zera Precos')and e.nroempresa = 1
order by b.seqproduto,b.codacesso;
