var ID, input;
ID = ds_map_find_value(async_load, "id")
if (ID == msg)
{
    if ds_map_find_value(async_load, "status")
    {
        input = ds_map_find_value(async_load, "value")
        if is_real(input)
        {
            random_set_seed(input)
            global.seed = input
            with (oGenerateSeed)
                event_user(0)
        }
    }
}
