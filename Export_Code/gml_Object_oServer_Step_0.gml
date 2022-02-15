var sockets, size, type, alignment, bufferSize, i, time;
if (prevPlayerListSize != ds_list_size(playerList) && ds_list_size(playerList) > 0)
{
    prevPlayerListSize = ds_list_size(playerList)
    sockets = ds_list_size(playerList)
    buffer_delete(buffer)
    size = 1024
    type = buffer_grow
    alignment = 1
    buffer = buffer_create(size, type, alignment)
    buffer_seek(buffer, buffer_seek_start, 0)
    buffer_write(buffer, buffer_u8, 102)
    buffer_write(buffer, buffer_string, strict_compress(ds_list_write(idList)))
    bufferSize = buffer_tell(buffer)
    buffer_seek(buffer, buffer_seek_start, 0)
    buffer_write(buffer, buffer_s32, bufferSize)
    buffer_write(buffer, buffer_u8, 102)
    buffer_write(buffer, buffer_string, strict_compress(ds_list_write(idList)))
    for (i = 0; i < sockets; i++)
        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
}
if (ds_list_size(playerList) > 0 && ds_list_size(timeList) > 0)
{
    if (ds_list_size(playerList) == ds_list_size(timeList) || ds_list_size(timeList) > ds_list_size(playerList))
    {
        ds_list_sort(timeList, 0)
        time = ds_list_find_value(timeList, 0)
        sockets = ds_list_size(playerList)
        buffer_delete(buffer)
        size = 1024
        type = buffer_grow
        alignment = 1
        buffer = buffer_create(size, type, alignment)
        buffer_seek(buffer, buffer_seek_start, 0)
        buffer_write(buffer, buffer_u8, 20)
        buffer_write(buffer, buffer_s32, time)
        bufferSize = buffer_tell(buffer)
        buffer_seek(buffer, buffer_seek_start, 0)
        buffer_write(buffer, buffer_s32, bufferSize)
        buffer_write(buffer, buffer_u8, 20)
        buffer_write(buffer, buffer_s32, time)
        for (i = 0; i < sockets; i++)
            network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
        ds_list_clear(timeList)
    }
}
if (ds_list_size(playerList) > 0 && ds_list_size(resetList) > 0)
{
    if (ds_list_size(playerList) == ds_list_size(resetList) || ds_list_size(resetList) > ds_list_size(playerList))
    {
        event_user(0)
        ds_list_clear(resetList)
    }
}
