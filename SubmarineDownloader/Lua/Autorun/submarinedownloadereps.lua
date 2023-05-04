-- put here the id of all workshop collections you want the script to download from.
-- example: {"2963343754"}
local workshopCollections = {2963343754}

-- path that submarines are going to be downloaded to.
local path = "LocalMods/SubmarineDownloader/Downloaded/"

if CLIENT then return end

if not Game.IsDedicated then
    error("Using this script in a non dedicated server doesn't make sense.")
    return
end

local function UpdateSubmarines()
    print("Updating submarine lobby.")
    SubmarineInfo.RefreshSavedSubs()
    local toReplace = {}

    for _, sub in pairs(SubmarineInfo.SavedSubmarines) do
        if sub.Type == 0 then
            table.insert(toReplace, sub)
        end
    end

    local files = File.DirSearch(path)

    local extension = ".sub"

    for key, value in pairs(files) do
        if value:sub(-#extension) == extension then
            local submarineInfo = SubmarineInfo(value)
            table.insert(toReplace, submarineInfo)
            SubmarineInfo.AddToSavedSubs(submarineInfo)
        end
    end

    Game.NetLobbyScreen.subs = toReplace

    for _, client in pairs(Client.ClientList) do
        client.LastRecvLobbyUpdate = 0
        Networking.ClientWriteLobby(client)
    end
end

local itemsBeingDownloaded = 0
local itemsDownloaded = 0

local function UpdateItem(id)
    Steam.GetWorkshopItem(UInt64(id), function (item)
        if item == nil then
            print(string.format("Couldn't find workshop item with id %s.", id))
            return
        end

        print(string.format("Downloading latest version of '%s'...", item.Title))

        Steam.DownloadWorkshopItem(item, path .. id, function (downloadedItem)
            itemsDownloaded = itemsDownloaded + 1
            print(string.format("(%s/%s) '%s' was successfully downloaded and placed in %s", itemsDownloaded, itemsBeingDownloaded, downloadedItem.Title, path .. id))

            if itemsDownloaded == itemsBeingDownloaded then
                print("Automatic Submarine Lobby Update Successful")
                UpdateSubmarines()
            end
        end)
    end)
end

local function UpdateAllItems()
    if File.DirectoryExists(path) then
        File.DeleteDirectory(path)
    end

    itemsBeingDownloaded = 0
    itemsDownloaded = 0

    for key, collection in pairs(workshopCollections) do
        Steam.GetWorkshopItem(collection, function (item)
            Steam.GetWorkshopCollection(collection, function (items)
                print(string.format("Retrieved %s items from collection '%s'", #items, item.Title))
                for key, value in pairs(items) do
                    UpdateItem(value)
                    itemsBeingDownloaded = itemsBeingDownloaded + 1
                end
            end)
        end)
    end
end

Game.AddCommand("updatesubmarines", "", function ()
    UpdateSubmarines()
end)

Game.AddCommand("updateworkshop", "", function ()
    UpdateAllItems()
end)

if ExecutionNumber == 0 then -- prevents reloadlua from re-executing this code
    Timer.Wait(function ()
        UpdateAllItems()
    end, 5000)
end
