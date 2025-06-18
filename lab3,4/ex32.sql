CREATE TABLE supplier (
    id_supplier SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(150) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(16)
);

CREATE TABLE recipient (
    id_recipient SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(150) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(16)
);

CREATE TABLE product (
    id_product SERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL, --в чеке накладной может быть до 128 символов для наименования товара
    release_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    id_supplier INTEGER NOT NULL REFERENCES supplier(id_supplier)
);

CREATE TABLE invoice (
    id_invoice SERIAL PRIMARY KEY,
    invoice_number VARCHAR(7) NOT NULL, --в накладной единый порядковый номер имеет 7 цифр
    total_amount DECIMAL(10,2) NOT NULL,
    manufacturer VARCHAR(150) NOT NULL,
    id_recipient INTEGER NOT NULL REFERENCES recipient(id_recipient),
    id_supplier INTEGER NOT NULL REFERENCES supplier(id_supplier)
);

CREATE TABLE invoice_product (
    id_invoice_product SERIAL PRIMARY KEY,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    id_invoice INTEGER NOT NULL REFERENCES invoice(id_invoice),
    id_product INTEGER NOT NULL REFERENCES product(id_product)
);