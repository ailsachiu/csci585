-- List all those villas that are equipped with Jacuzzi and follow a no-pet policy

select distinct jc.jacuzzi_villa as villa_id
from(
		select VILLA.villa_id as no_pool_villa
        from VILLA join VILLA_FEATURES on VILLA.villa_id = VILLA_FEATURES.villa_id 
		where VILLA_FEATURES.feature_id != 'Fea6'
	) as np
    inner join
    (
		select VILLA.villa_id as jacuzzi_villa
        from VILLA join VILLA_FEATURES on VILLA.villa_id = VILLA_FEATURES.villa_id 
		where VILLA_FEATURES.feature_id = 'Fea2'
    ) as jc
    on jc.jacuzzi_villa = np.no_pool_villa;

-- RETURNS
-- 'Vil1'
-- 'Vil4'
-- 'Vil11'
-- 'Vil12'
