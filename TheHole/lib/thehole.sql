
CREATE DATABASE IF NOT EXISTS thehole;
USE thehole;


CREATE TABLE IF NOT EXISTS exploits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_exploit VARCHAR(255) NOT NULL,
    tecnologia VARCHAR(100) NOT NULL,
    versao_afetada VARCHAR(50) NOT NULL,
    cve VARCHAR(20),
    descricao TEXT,
    tipo VARCHAR(50),
    exploit_url VARCHAR(255),
    nivel_risco ENUM('Baixo', 'Médio', 'Alto', 'Crítico') DEFAULT 'Médio',
    data_publicacao DATE
);


INSERT INTO exploits (
    nome_exploit, tecnologia, versao_afetada, cve, descricao, tipo, exploit_url, nivel_risco, data_publicacao
) VALUES
(
    'Spring4Shell',
    'Spring Core',
    '<=5.3.17',
    'CVE-2022-22965',
    'Remote Code Execution via ClassLoader',
    'RCE',
    'https://www.exploit-db.com/exploits/50851',
    'Crítico',
    '2022-03-31'
),
(
    'Swagger UI XSS',
    'Swagger UI',
    '2.0.0-3.23.0',
    'CVE-2019-17495',
    'Stored XSS on Swagger editor',
    'XSS',
    'https://www.exploit-db.com/exploits/47690',
    'Médio',
    '2019-10-16'
),
(
    'GraphQL Introspection Disclosure',
    'GraphQL',
    'All',
    NULL,
    'GraphQL exposes internal schema and queries',
    'Info',
    'https://github.com/dolevf/graphw00f',
    'Baixo',
    '2021-12-01'
);

