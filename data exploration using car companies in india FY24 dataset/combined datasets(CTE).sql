CREATE TABLE CarCompanies AS
SELECT 'Hyundai' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM hyundai_company
UNION ALL
SELECT 'Maruti Suzuki' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM maruti_suzuki_company
UNION ALL
SELECT 'Tata' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM tata_company
UNION ALL
SELECT 'Mahindra' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM mahindra_company
UNION ALL
SELECT 'Toyota' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM toyota_company
UNION ALL
SELECT 'Kia' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM kia_company
UNION ALL
SELECT 'Honda' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM honda_company
UNION ALL
SELECT 'MG' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM mg_company
UNION ALL
SELECT 'Renault' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM renault_company
UNION ALL
SELECT 'Volkswagen' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM volkswagen_company
UNION ALL
SELECT 'Skoda' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM skoda_company
UNION ALL
SELECT 'Nissan' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM nissan_company
UNION ALL
SELECT 'Citroen' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM citroen_company
UNION ALL
SELECT 'Jeep' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM jeep_company
UNION ALL
SELECT 'Force' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM force_company
UNION ALL
SELECT 'Isuzu' AS company_name, car_id, sale_id, model_name, model_type, origin,
       engine_displacement, engine_capacity, engine_name, transmission, transmission_name,
       variants, seater_count, boot_space, tank_capacity, fuel_type, mileage,
       ex_showroom_price_from, on_road_price_from, avg_models_per_month, manufacturing_locations_in_india,
       ncap_test, no_of_units_sold_in_FY24, profit_by_model, loss_by_model, estimated_revenue, first_sale_date
FROM isuzu_company;