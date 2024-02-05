bot = getBot()

function say(od)
    bot:say(od)
end

function OdBot()
    if bot.status == BotStatus.online then
        Status = "online"
    elseif bot.status == BotStatus.wrong_password then
        Status = "wrong"
    elseif bot.status == BotStatus.account_banned then
        Status = "acc banned"
    elseif bot.status == BotStatus.location_banned then
        Status = "ip banned"
    elseif bot.status == BotStatus.version_update then
        Status = "update version"
    elseif bot.status == BotStatus.maintenance then
        Status = "maintenance"
    elseif bot.status == BotStatus.advanced_account_protection then
        Status = "AAP"
    elseif bot.status == BotStatus.guest_limit then
        Status = "guestError"
    else
        Status = "offline"
    end

    if not GuestAkun then
        erine = bot.name
    else
        if not erine then
            if bot:isInWorld() then
                erine = getLocal().name
            else
                erine = bot.name
            end
        else
            if not string.match(erine, "_%d+") then
                if bot:isInWorld() then
                    erine = getLocal().name
                else
                    erine = bot.name
                end
            end
        end
    end

    return {
        world = bot:getWorld().name,
        name = erine,
        x = bot.x,
        y = bot.y,
        level = bot.level,
        status = Status,
        gems = bot.gem_count,
        items = bot:getInventory().itemcount,
        slots = bot:getInventory().slotcount,
    }
end

function getPlayers()
    world = bot:getWorld()
    local orang = {}
    for _,ppl in pairs(world:getPlayers()) do
        table.insert(orang, { name = ppl.name, userid = ppl.userid, netid = ppl.netid, country = ppl.country, x = math.floor(ppl.posx / 32), y = math.floor(ppl.posy / 32)})
    end
    return orang
end

function findClothes(id)
    return bot:getInventory():getItem(id).isActive
end

function wear(id)
    bot:wear(id)
end

function getPing()
    return bot:getPing()
end

function findItem(id)
    return bot:getInventory():findItem(id)
end

function collect(erin)
    bot:collect(erin, 100)
end


function findPath(x,y)
    bot:findPath(x,y)
end

function wrench(x, y)
    bot:wrench(bot.x + x, bot.y + y)
end

function punch(x, y)
    bot:hit(bot.x + x, bot.y + y)
end

function place(id, x, y)
    bot:place(bot.x + x, bot.y + y, id)
end

function sendPacket(typ, pkt)
    bot:sendPacket(typ, pkt)
end


function drop(id, count)
    if count then
        bot:drop(id, count)
    else
        bot:drop(id, findItem(id))
    end
end

function trash(id, count)
    if count then
        bot:trash(id, count)
    else
        bot:trash(id, findItem(id))
    end
end

function collectSet(erin, jarak)
    bot.collect_interval = 200
    bot.object_collect_delay = 100
    bot.collect_range = jarak
    bot.auto_collect = erin
end

function disconnect()
    bot:disconnect()
end

function connect()
    bot:connect()
end

function getTile(x, y)
    world = bot:getWorld()
    tilefg = 0
    tilebg = 0
    tileflags = 0
    tileready = false
    if bot:isInWorld() then
        tilefg = world:getTile(x, y).fg
        tilebg = world:getTile(x, y).bg
        tileflags = world:getTile(x, y).flags
        tileready = world:getTile(x, y):canHarvest()
    end
    return {
        fg = tilefg,
        bg = tilebg,
        flags = tileflags,
        ready = tileready,
    }
end

function getInventory()
    local tas = {}
    for _,bag in pairs(bot:getInventory():getItems()) do
        table.insert(tas, { id = bag.id, count = bag.count})
    end
    return tas
end

function getTiles()
    world = bot:getWorld()
    local tiles = {}
    for _,tile in pairs(world:getTiles()) do
        if bot:isInWorld() then
            table.insert(tiles, { x = tile.x, y = tile.y, fg = tile.fg, bg = tile.bg, ready = tile:canHarvest(), flags = tile.flags})
        end
    end
    return tiles
end

function getObjects()
    world = bot:getWorld()
    local object = {}
    for _,obj in pairs(world:getObjects()) do
        table.insert(object, { x = obj.x, y = obj.y, id = obj.id, uid = obj.oid, count = obj.count, flags = obj.flags})
    end
    return object
end

function GetNameID(id)
    return getInfo(id).name
end

function warp(Dunia, Kunci)
    if Kunci then
        bot:warp(Dunia.."|"..Kunci)
    else
        bot:warp(Dunia)
    end
end

function buy(pek)
    sendPacket(2, "action|buy\nitem|"..pek)
end

function Upgrades()
    sendPacket(2, "action|buy\nitem|upgrade_backpack")
end
