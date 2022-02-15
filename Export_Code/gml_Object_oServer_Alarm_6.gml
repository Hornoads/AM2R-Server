var size, type, alignment, i, j, bufferSize, sockets;
size = 1024
type = buffer_grow
alignment = 1
dmapBuffer = buffer_create(size, type, alignment)
buffer_seek(dmapBuffer, buffer_seek_start, 0)
buffer_write(dmapBuffer, buffer_u8, 53)
buffer_write(dmapBuffer, buffer_u8, 2)
for (i = 0; i < array_height_2d(global.dmap); i++)
{
    for (j = 0; j < array_length_2d(global.dmap, i); j++)
    {
        if (i >= 20 && i < 40)
            buffer_write(dmapBuffer, buffer_u8, global.dmap[i, j])
    }
}
bufferSize = buffer_tell(dmapBuffer)
buffer_seek(dmapBuffer, buffer_seek_start, 0)
buffer_write(dmapBuffer, buffer_s32, bufferSize)
buffer_write(dmapBuffer, buffer_u8, 53)
buffer_write(dmapBuffer, buffer_u8, 2)
for (i = 0; i < array_height_2d(global.dmap); i++)
{
    for (j = 0; j < array_length_2d(global.dmap, i); j++)
    {
        if (i >= 20 && i < 40)
            buffer_write(dmapBuffer, buffer_u8, global.dmap[i, j])
    }
}
sockets = ds_list_size(playerList)
for (i = 0; i < sockets; i++)
    network_send_packet(ds_list_find_value(playerList, i), dmapBuffer, buffer_tell(dmapBuffer))
buffer_delete(dmapBuffer)
alarm[7] = 120
