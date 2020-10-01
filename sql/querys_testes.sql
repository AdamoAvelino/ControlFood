SELECT c.nome, c.cpf, c.rg, l.logradouro, e.nome_logradouro, e.numero, e.cep, cid.cidade, uf.uf
FROM cliente c
JOIN local_enderecos e ON c.id_endereco = e.id
JOIN local_logradouros l ON e.id_logradouro = l.id
JOIN local_cidades cid ON e.id_cidade = cid.id
JOIN local_ufs uf ON uf.id = cid.id_uf;



-- Consuta de pratos com produtos e produtos manufaturados
SELECT pr.nome prato, pm.nome manufaturado, p.nome produto, pmc.quantidade
 , um.nome un, pr.valor_venda
FROM pratos pr
JOIN prato_produto_manufaturados ppm ON ppm.id_prato = pr.id
JOIN produto_manufaturados pm ON pm.id = ppm.id_produto_manufaturado
JOIN produto_manufaturado_configuracoes pmc ON pm.id = pmc.id_produto_manufaturado
JOIN produtos p ON p.id = pmc.id_produto
JOIN unidade_medida um ON um.id = p.id_unidade_medida
 -- WHERE pr.id = 4 
ORDER BY prato;


-- -------------- Trabalhando -- ---------------------------------
-- Consulta de produtos como estoque

SELECT p.nome nome
, IF(GROUP_CONCAT(en.id) != '', 
		SUM(en.quantidade_produto) - IF(GROUP_CONCAT(s.id)= '', 0, SUM(s.quantidade)), 
	   0
	 ) quantidade
, um.nome unidade_medida

FROM produtos p
JOIN unidade_medida um ON um.id = p.id_unidade_medida
LEFT JOIN entrada en ON en.id_produto = p.id
LEFT JOIN nota_fiscal_items nfi ON nfi.id = en.id_nota_fiscal_item
LEFT JOIN saida s ON s.id_entrada = en.id
GROUP BY p.id;