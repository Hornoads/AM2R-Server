var size, type, alignment, i, bufferSize, sockets;
if global.itemSync
{
    size = 1024
    type = buffer_grow
    alignment = 1
    itemBuffer = buffer_create(size, type, alignment)
    buffer_seek(itemBuffer, buffer_seek_start, 0)
    buffer_write(itemBuffer, buffer_u8, 50)
    for (i = 0; i < array_length_1d(global.item); i++)
        buffer_write(itemBuffer, buffer_u8, global.item[i])
    bufferSize = buffer_tell(itemBuffer)
    buffer_seek(itemBuffer, buffer_seek_start, 0)
    buffer_write(itemBuffer, buffer_s32, bufferSize)
    buffer_write(itemBuffer, buffer_u8, 50)
    for (i = 0; i < array_length_1d(global.item); i++)
        buffer_write(itemBuffer, buffer_u8, global.item[i])
    sockets = ds_list_size(playerList)
    for (i = 0; i < sockets; i++)
        network_send_packet(ds_list_find_value(playerList, i), itemBuffer, buffer_tell(itemBuffer))
    buffer_delete(itemBuffer)
    alarm[2] = 300
}
else
    alarm[2] = 300
