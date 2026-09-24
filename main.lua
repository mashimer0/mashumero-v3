-- Orion Lib ロード
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jadpy/suki/refs/heads/main/orion'))()

-- ウィンドウ作成
local Window = OrionLib:MakeWindow({
    Name = "ましゅめろキック",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ましゅめろキック",
    IntroEnabled = true,
    IntroText = "by ましゅめろ",
    Theme = {
        Background = Color3.fromRGB(20, 20, 20),
        ElementBackground = Color3.fromRGB(30, 30, 30),
        TabBackground = Color3.fromRGB(25, 25, 25),
        TabBackgroundSelected = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(240, 240, 240),
        Shadow = Color3.fromRGB(200, 200, 200),
        SliderProgress = Color3.fromRGB(200, 200, 200),
        ElementStroke = Color3.fromRGB(200, 200, 200),
        TabStroke = Color3.fromRGB(200, 200, 200),
        ToggleEnabled = Color3.fromRGB(200, 200, 200),
        ToggleBackground = Color3.fromRGB(80, 80, 80),
        InputBackground = Color3.fromRGB(40, 40, 40),
        DropdownSelected = Color3.fromRGB(60, 60, 60),
        DropdownUnselected = Color3.fromRGB(30, 30, 30),
        NotificationBackground = Color3.fromRGB(30, 30, 30),
        Topbar = Color3.fromRGB(25, 25, 25)
    }
})

-- ==========================================
-- ★★★ 旧れもにーHUB（ましゅめろ）を自動起動 ★★★
-- ==========================================
task.spawn(function()
    local lemonScript = [[
-- ==============================================================================
-- ましゅめろ（旧れもにーHUB） - 完全版（全機能復活）
-- 全UI日本語化 / ましゅめろキックと連携
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("MashumeroHub_Blocker") then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🚫 ブロック済み",
            Text = "ましゅめろは既に起動しています。",
            Duration = 3,
        })
    end)
    return
end

local blocker = Instance.new("BoolValue")
blocker.Name = "MashumeroHub_Blocker"
blocker.Parent = CoreGui

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

print("✅ ましゅめろ 起動: " .. LocalPlayer.Name)

local function showHackMessage(text, color, duration)
    color = color or Color3.fromRGB(0,255,0)
    duration = duration or 2
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HackMessage"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,60)
    frame.Position = UDim2.new(0,0,0,0)
    frame.BackgroundTransparency = 0.2
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = color
    frame.Parent = screenGui
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextScaled = true
    label.Font = Enum.Font.Code
    label.TextWrapped = true
    label.Parent = frame
    task.delay(duration, function()
        frame:TweenSize(UDim2.new(1,0,0,0), "Out", "Quad", 0.5, true)
        task.wait(0.6)
        screenGui:Destroy()
    end)
end

local function screenFlash(color, duration)
    color = color or Color3.fromRGB(255,0,0)
    duration = duration or 0.3
    local flash = Instance.new("Frame")
    flash.Size = UDim2.new(1,0,1,0)
    flash.BackgroundColor3 = color
    flash.BackgroundTransparency = 0.8
    flash.BorderSizePixel = 0
    flash.Parent = game:GetService("CoreGui")
    flash.ZIndex = 999
    TweenService:Create(flash, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    task.delay(duration + 0.1, function() flash:Destroy() end)
end

local function createBloodMoon()
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.fromRGB(60,10,10)
    lighting.ColorShift_Top = Color3.fromRGB(200,40,40)
    lighting.ColorShift_Bottom = Color3.fromRGB(80,10,10)
    lighting.Brightness = 0.7
    lighting.OutdoorAmbient = Color3.fromRGB(100,20,20)
    lighting.SunTextureId = "rbxassetid://14588417062"
    lighting.SunAngularSize = 30
    lighting.MoonTextureId = "rbxassetid://14588417062"
    lighting.MoonAngularSize = 30
    local moonPart = Instance.new("Part")
    moonPart.Name = "BloodMoonPart"
    moonPart.Size = Vector3.new(150,150,150)
    moonPart.Shape = Enum.PartType.Ball
    moonPart.BrickColor = BrickColor.new("Really red")
    moonPart.Material = Enum.Material.Neon
    moonPart.Anchored = true
    moonPart.CanCollide = false
    moonPart.CFrame = CFrame.new(Vector3.new(0,900,-2000))
    moonPart.Parent = workspace
    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(255,50,50)
    pointLight.Range = 3000
    pointLight.Brightness = 3
    pointLight.Parent = moonPart
    local atmosphere = lighting:FindFirstChild("Atmosphere")
    if not atmosphere then
        atmosphere = Instance.new("Atmosphere")
        atmosphere.Parent = lighting
    end
    atmosphere.Density = 0.6
    atmosphere.Color = Color3.fromRGB(120,20,20)
    atmosphere.Decay = 0.4
    atmosphere.Glare = 0.3
    local stars = Instance.new("ParticleEmitter")
    stars.Name = "BloodStars"
    stars.Texture = "rbxassetid://10828533857"
    stars.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(200,50,50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100,0,0))})
    stars.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2), NumberSequenceKeypoint.new(1,6)})
    stars.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.6), NumberSequenceKeypoint.new(1,1)})
    stars.Lifetime = NumberRange.new(5,10)
    stars.Rate = 20
    stars.SpreadAngle = Vector2.new(360,360)
    stars.VelocityInheritance = 0
    stars.Acceleration = Vector3.new(0,0.5,0)
    stars.Enabled = true
    local starContainer = Instance.new("Part")
    starContainer.Name = "BloodStarContainer"
    starContainer.Size = Vector3.new(1,1,1)
    starContainer.Anchored = true
    starContainer.CanCollide = false
    starContainer.Transparency = 1
    starContainer.CFrame = CFrame.new(0,500,0)
    starContainer.Parent = workspace
    stars.Parent = starContainer
    print("🌕 ブラッドムーンエフェクト適用")
end


loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

local function sendChatMessage(msg)
    local TextChatService = game:GetService("TextChatService")
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local generalChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if generalChannel then generalChannel:SendAsync(msg) end
    else
        local defaultChat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if defaultChat then
            local sayMessage = defaultChat:FindFirstChild("SayMessageRequest")
            if sayMessage then sayMessage:FireServer(msg, "All") end
        end
    end
end
sendChatMessage("👾ましゅめろ")

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles
Library.ForceCheckbox = false

local Window = Library:CreateWindow({
    Title = "👾 ましゅめろ",
    Footer = "Made by GR",
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Defense = Window:AddTab("defense", "🛡️ 防御"),
    Target = Window:AddTab("target", "🎯 ターゲット"),
    Grab = Window:AddTab("grab", "✋ 掴み"),
    Player = Window:AddTab("player", "👤 プレイヤー"),
    Misc = Window:AddTab("misc", "📦 その他"),
    Build = Window:AddTab("build", "🔧 ビルド"),
    LagKick = Window:AddTab("lagkick", "⏱️ ラグキック"),
    Backpack = Window:AddTab("おんぶ", "🎒 おんぶ"),
    PlotBreak = Window:AddTab("プロットブレイク", "🏠 プロット破壊"),
    ["UI Settings"] = Window:AddTab("UI Settings", "⚙️ UI設定")
}

Tabs.Defense.Label = "🛡️ 防御"
Tabs.Target.Label = "🎯 ターゲット"
Tabs.Grab.Label = "✋ 掴み"
Tabs.Player.Label = "👤 プレイヤー"
Tabs.Misc.Label = "📦 その他"
Tabs.Build.Label = "🔧 ビルド"
Tabs.LagKick.Label = "⏱️ ラグキック"
Tabs.Backpack.Label = "🎒 おんぶ"
Tabs.PlotBreak.Label = "🏠 プロット破壊"
Tabs["UI Settings"].Label = "⚙️ UI設定"

local PS = Players
local RS = ReplicatedStorage
local R = RunService
local Player = LocalPlayer
local Camera = Workspace.CurrentCamera

local function notify(title, content, duration)
    Library:Notify({ Title = title or "通知", Description = content or "", Time = duration or 5 })
end

local function sendHubLoadedMessage()
    local message = "👾 ましゅめろ | 読み込み完了 "
    pcall(function()
        local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvents then
            local say = chatEvents:FindFirstChild("SayMessageRequest")
            if say and typeof(say.FireServer) == "function" then
                say:FireServer(message, "All")
            end
        end
    end)
end
task.spawn(function() task.wait(1) sendHubLoadedMessage() end)

local function getPlayerList()
    local list = {}
    for _, plr in ipairs(PS:GetPlayers()) do
        if plr ~= Player then table.insert(list, plr.DisplayName .. " (" .. plr.Name .. ")") end
    end
    return list
end
local function getPlayerFromSelection(selection)
    if not selection then return nil end
    local username = selection:match("%((.-)%)")
    if username then return PS:FindFirstChild(username) end
    return nil
end

-- =====================================================
-- Defense Tab (防御) - 全機能
-- =====================================================
local DefenseGroup = Tabs.Defense:AddLeftGroupbox("🛡️ メイン防御")
local DefenseExtra = Tabs.Defense:AddRightGroupbox("🔧 追加防御")

local autoStruggleConn = nil
DefenseGroup:AddToggle("AntiGrabObsidian", {
    Text = "アンチグラブ",
    Default = false,
    Callback = function(Value)
        local Struggle = ReplicatedStorage:FindFirstChild("CharacterEvents") and ReplicatedStorage.CharacterEvents:FindFirstChild("Struggle")
        if Value then
            if autoStruggleConn then autoStruggleConn:Disconnect() end
            autoStruggleConn = RunService.Heartbeat:Connect(function()
                local character = Player.Character
                if character and character:FindFirstChild("Head") then
                    local head = character.Head
                    if head:FindFirstChild("PartOwner") then
                        task.spawn(function()
                            if Struggle then Struggle:FireServer(Player) end
                            for _, part in pairs(character:GetChildren()) do
                                if part:IsA("BasePart") then part.Anchored = true end
                            end
                            local isHeld = Player:FindFirstChild("IsHeld")
                            while isHeld and isHeld.Value do task.wait() end
                            for _, part in pairs(character:GetChildren()) do
                                if part:IsA("BasePart") then part.Anchored = false end
                            end
                        end)
                    end
                end
            end)
        else
            if autoStruggleConn then autoStruggleConn:Disconnect() autoStruggleConn = nil end
        end
    end
})

local antiBlob1T=false
local function antiBlob1F()
    antiBlob1T=true
    workspace.DescendantAdded:Connect(function(toy)
        if toy.Name=="CreatureBlobman" and antiBlob1T then
            toy.LeftDetector:Destroy()
            toy.RightDetector:Destroy()
        end
    end)
end
DefenseGroup:AddToggle("AntiBlobmanToggle", {Text="アンチブロブマン", Default=false, Callback=function(on) if on then antiBlob1F() else antiBlob1T=false end end})

local antiExplodeT=false
local function antiExplodeF()
    antiExplodeT=true
    local char=Player.Character
    if not char then return end
    local hrp=char:WaitForChild("HumanoidRootPart")
    workspace.ChildAdded:Connect(function(model)
        if model.Name=="Part" and antiExplodeT then
            local mag=(model.Position-hrp.Position).Magnitude
            if mag<=20 then
                hrp.Anchored=true
                wait(0.01)
                while char["Right Arm"].RagdollLimbPart.CanCollide do wait(0.001) end
                hrp.Anchored=false
            end
        end
    end)
end
DefenseGroup:AddToggle("AntiExplosionToggle", {Text="アンチ爆発", Default=false, Callback=function(on) if on then antiExplodeF() else antiExplodeT=false end end})

local hookBurnConn
local function hookBurn(char)
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    char.PrimaryPart = hrp
    if hookBurnConn then hookBurnConn:Disconnect() end
    hookBurnConn = hum.FireDebounce.Changed:Connect(function(isBurning)
        if isBurning then
            local me = char
            local oldCF = hrp.CFrame
            local plots = workspace:FindFirstChild("Plots")
            if plots and plots:FindFirstChild("Plot2") then
                local plot2 = plots.Plot2
                local barrier = plot2:FindFirstChild("Barrier")
                local pb = barrier and barrier:FindFirstChild("PlotBarrier")
                if pb and pb:IsA("BasePart") then
                    local safeCF = pb.CFrame * CFrame.new(0,6,0)
                    me:SetPrimaryPartCFrame(safeCF)
                    task.wait(0.3)
                    local firePart = me:FindFirstChild("FirePlayerPart", true)
                    if firePart then
                        for _, obj in ipairs(firePart:GetChildren()) do
                            if obj:IsA("Sound") then obj:Stop() end
                            if obj:IsA("Light") or obj:IsA("ParticleEmitter") then obj.Enabled = false end
                        end
                        if firePart:FindFirstChild("CanBurn") then firePart.CanBurn.Value = false end
                        if hum:FindFirstChild("FireDebounce") then hum.FireDebounce.Value = false end
                    end
                    task.wait(0.6)
                    if me and me.PrimaryPart then me:SetPrimaryPartCFrame(oldCF) end
                end
            end
        end
    end)
end
DefenseGroup:AddToggle("AntiBurnToggle", {Text="アンチ炎上", Default=false, Callback=function(on) if on then hookBurn(Player.Character) elseif hookBurnConn then hookBurnConn:Disconnect() end end})

local antiVoidConn
local VOID_THRESHOLD = -50
local SAFE_HEIGHT = 100
DefenseGroup:AddToggle("AntiVoidToggle", {Text="アンチ落下", Default=false, Callback=function(on)
    if on then
        if antiVoidConn then antiVoidConn:Disconnect() end
        antiVoidConn = R.Heartbeat:Connect(function()
            local char = Player.Character
            if char and char.PrimaryPart then
                local pos = char.PrimaryPart.Position
                if pos.Y < VOID_THRESHOLD then
                    local safePos = Vector3.new(pos.X, pos.Y + SAFE_HEIGHT, pos.Z)
                    char:SetPrimaryPartCFrame(CFrame.new(safePos))
                    char.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
                end
            end
        end)
    else
        if antiVoidConn then antiVoidConn:Disconnect() antiVoidConn = nil end
    end
end})

local antiStickyT = false
DefenseGroup:AddToggle("AntiStickyToggle", {Text="アンチ粘着", Default=false, Callback=function(Value)
    antiStickyT = Value
    if Player.PlayerScripts:FindFirstChild("StickyPartsTouchDetection") then
        Player.PlayerScripts.StickyPartsTouchDetection.Disabled = Value
    end
end})

local createGrabLineCopy, extendGrabLineCopy
local grabFolder = ReplicatedStorage:FindFirstChild("GrabEvents")
if grabFolder then
    local originalCreate = grabFolder:FindFirstChild("CreateGrabLine")
    local originalExtend = grabFolder:FindFirstChild("ExtendGrabLine")
    if originalCreate then createGrabLineCopy = originalCreate:Clone() end
    if originalExtend then extendGrabLineCopy = originalExtend:Clone() end
end
DefenseGroup:AddToggle("AntiLagToggle", {Text="アンチラグ", Default=false, Callback=function(Value)
    if Value then
        local grabFolder = ReplicatedStorage:FindFirstChild("GrabEvents")
        if grabFolder then
            local create = grabFolder:FindFirstChild("CreateGrabLine")
            local extend = grabFolder:FindFirstChild("ExtendGrabLine")
            if create and create:IsA("RemoteEvent") then create:Destroy() end
            if extend and extend:IsA("RemoteEvent") then extend:Destroy() end
        end
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Beam") or v.Name:lower():find("line") then v:Destroy() end
        end
    else
        local grabFolder = ReplicatedStorage:FindFirstChild("GrabEvents")
        if grabFolder then
            if createGrabLineCopy and not grabFolder:FindFirstChild("CreateGrabLine") then
                local restoredCreate = createGrabLineCopy:Clone()
                restoredCreate.Parent = grabFolder
            end
            if extendGrabLineCopy and not grabFolder:FindFirstChild("ExtendGrabLine") then
                local restoredExtend = extendGrabLineCopy:Clone()
                restoredExtend.Parent = grabFolder
            end
        end
    end
end})

-- Paint Delete
local paintPartsBackup = {}
local paintConnections = {}
local function deleteAllPaintParts()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "PaintPlayerPart" then
            local clone = obj:Clone()
            clone.Archivable = true
            paintPartsBackup[obj:GetDebugId()] = { clone = clone, parent = obj.Parent }
            obj:Destroy()
        end
    end
end
local function restorePaintParts()
    for _, data in pairs(paintPartsBackup) do
        if data.clone and data.parent then data.clone.Parent = data.parent end
    end
    paintPartsBackup = {}
end
local function watchNewPaintParts()
    table.insert(paintConnections, Workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("BasePart") and obj.Name == "PaintPlayerPart" then
            task.defer(function()
                if obj and obj.Parent then
                    local clone = obj:Clone()
                    clone.Archivable = true
                    paintPartsBackup[obj:GetDebugId()] = { clone = clone, parent = obj.Parent }
                    obj:Destroy()
                end
            end)
        end
    end))
end
local function disconnectWatchers()
    for _, conn in ipairs(paintConnections) do if conn.Connected then conn:Disconnect() end end
    paintConnections = {}
end
local function setTouchQuery(state)
    local char = Workspace:FindFirstChild(Player.Name)
    if not char then return end
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("Part") or v:IsA("BasePart") then v.CanTouch = state v.CanQuery = state end
    end
end
DefenseExtra:AddToggle("PaintDeleteToggle", {Text="アンチペイント", Default=false, Callback=function(state)
    if state then deleteAllPaintParts() watchNewPaintParts() setTouchQuery(false)
    else restorePaintParts() disconnectWatchers() setTouchQuery(true) end
end})

-- Anti Gucci (Blobman)
local antiGucciConnection
local safePosition
local restoreFrames = 0
local function spawnBlobman()
    local args = {[1] = "CreatureBlobman", [2] = CFrame.new(0,5000000,0), [3] = Vector3.new(0,60,0)}
    pcall(function() ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer(unpack(args)) end)
    local folder = Workspace:WaitForChild(Player.Name.."SpawnedInToys", 5)
    if folder and folder:FindFirstChild("CreatureBlobman") then
        local blob = folder.CreatureBlobman
        if blob:FindFirstChild("Head") then blob.Head.CFrame = CFrame.new(0,50000,0) blob.Head.Anchored = true end
        notify("成功", "ブロブマンを召喚しました！", 3)
    end
end
local function startAntiGucci()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    safePosition = rootPart.Position
    local folder = Workspace:FindFirstChild(Player.Name.."SpawnedInToys")
    local blob = folder and folder:FindFirstChild("CreatureBlobman")
    local seat = blob and blob:FindFirstChild("VehicleSeat")
    if not blob then spawnBlobman() task.wait(1) folder = Workspace:FindFirstChild(Player.Name.."SpawnedInToys") blob = folder and folder:FindFirstChild("CreatureBlobman") seat = blob and blob:FindFirstChild("VehicleSeat") end
    if seat and seat:IsA("VehicleSeat") then rootPart.CFrame = seat.CFrame + Vector3.new(0,2,0) seat:Sit(humanoid) end
    humanoid:GetPropertyChangedSignal("Jump"):Connect(function() if humanoid.Jump and humanoid.Sit then restoreFrames = 15 safePosition = rootPart.Position end end)
    if antiGucciConnection then antiGucciConnection:Disconnect() end
    antiGucciConnection = R.Heartbeat:Connect(function()
        if not rootPart or not humanoid then return end
        ReplicatedStorage.CharacterEvents.RagdollRemote:FireServer(rootPart, 0)
        if restoreFrames > 0 then rootPart.CFrame = CFrame.new(safePosition) restoreFrames = restoreFrames - 1 end
    end)
    task.spawn(function() while humanoid.Sit do task.wait(1) end task.wait(0.5) rootPart.CFrame = CFrame.new(safePosition) end)
end
local function stopAntiGucci()
    if antiGucciConnection then antiGucciConnection:Disconnect() antiGucciConnection = nil end
    local blobFolder = Workspace:FindFirstChild(Player.Name.."SpawnedInToys")
    if blobFolder and blobFolder:FindFirstChild("CreatureBlobman") then blobFolder.CreatureBlobman:Destroy() end
end
local autoGucciActive = false
DefenseExtra:AddToggle("AutoGucciToggle", {Text="アンチグッチ (ブロブマン)", Default=false, Callback=function(Value)
    autoGucciActive = Value
    if Value then
        startAntiGucci()
        notify("システム", "アンチグッチ 起動中", 3)
        task.spawn(function()
            while autoGucciActive do
                local toysFolder = Workspace:FindFirstChild(Player.Name.."SpawnedInToys")
                local blobExists = toysFolder and toysFolder:FindFirstChild("CreatureBlobman")
                if not blobExists then
                    stopAntiGucci()
                    spawnBlobman()
                    notify("システム", "ブロブマン消失、再召喚", 3)
                    local retries = 0
                    repeat
                        task.wait(0.2)
                        retries = retries + 1
                        toysFolder = Workspace:FindFirstChild(Player.Name.."SpawnedInToys")
                    until (toysFolder and toysFolder:FindFirstChild("CreatureBlobman")) or retries > 25 or not autoGucciActive
                    if autoGucciActive and toysFolder and toysFolder:FindFirstChild("CreatureBlobman") then
                        startAntiGucci()
                        notify("システム", "ブロブマン復活", 3)
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        autoGucciActive = false
        stopAntiGucci()
        notify("システム", "アンチグッチ 停止", 3)
    end
end})

local autoGucciActiveTrain = false
DefenseExtra:AddToggle("AutoGucciToggle", {Text="アンチグッチ (電車)", Default=false, Callback=function(Value)
    autoGucciActiveTrain = Value
    if Value then
        startAntiGucciTrain()
        notify("システム", "アンチグッチ(電車) 起動中", 3)
        task.spawn(function()
            while autoGucciActiveTrain do
                local trainFolder = workspace.Map.AlwaysHereTweenedObjects
                local trainExists = trainFolder and trainFolder:FindFirstChild("Train")
                if not trainExists then
                    stopAntiGucciTrain()
                    notify("システム", "電車消失", 3)
                    local retries = 0
                    repeat
                        task.wait(0.2)
                        retries = retries + 1
                        trainFolder = workspace.Map.AlwaysHereTweenedObjects
                    until (trainFolder and trainFolder:FindFirstChild("Train")) or retries > 25 or not autoGucciActiveTrain
                    if autoGucciActiveTrain and trainFolder and trainFolder:FindFirstChild("Train") then
                        startAntiGucciTrain()
                        notify("システム", "電車復活", 3)
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        autoGucciActiveTrain = false
        stopAntiGucciTrain()
        notify("システム", "アンチグッチ(電車) 停止", 3)
    end
end})

-- Anti Input Lag (Item Loop)
local ToyList = {
    ["ココナッツ"]="FoodCoconut", ["バナナ"]="FoodBanana", ["ポテト"]="FoodFrenchFries", ["肉串"]="FoodMeatStick",
    ["うんち"]="PoopPile", ["ドーナツ"]="FoodDonut", ["ケーキ"]="FoodCakePink", ["ハンバーガー"]="FoodHamburger",
    ["ピザ"]="FoodPizzaCheese", ["ホットドッグ"]="FoodHotdog", ["キノコ"]="FoodMushroomPoison",
    ["バンジョー"]="InstrumentGuitarBanjo", ["バイオリン"]="InstrumentGuitarViolin", ["ウクレレ"]="InstrumentGuitarUkulele",
    ["サックス"]="InstrumentWoodwindSaxophone", ["ブブゼラ"]="InstrumentBrassVuvuzela", ["ボンゴ"]="InstrumentDrumBongos",
    ["マイク"]="InstrumentVoiceMicrophone", ["ペパロニ"]="FoodPizzaPepperoni", ["ピアノ"]="InstrumentPianoMelodica",
    ["パン"]="FoodBread", ["卵"]="FoodDippyEgg", ["マヨネーズ"]="FoodMayonnaise", ["白マグカップ"]="CupMugWhite",
    ["オカリナ"]="InstrumentWoodwindOcarina", ["キラキラうんち"]="PoopPileSparkle", ["茶マグカップ"]="CupMugBrown",
    ["トランペット"]="InstrumentBrassTrumpet", ["スネアドラム"]="InstrumentDrumSnare",
}
local displayNames = {}
for name,_ in pairs(ToyList) do table.insert(displayNames, name) end
table.sort(displayNames)
_G.AntiInputLagItem = ToyList["ハンバーガー"]
_G.AntiInputLagRunning = false
local AntiInputLagTask = nil

DefenseExtra:AddDropdown("AntiInputLagToy", {
    Values = displayNames,
    Default = 1,
    Multi = false,
    Text = "使用アイテム",
    Callback = function(Value)
        local selected = Value or "ハンバーガー"
        if ToyList[selected] then
            _G.AntiInputLagItem = ToyList[selected]
            notify("アイテム変更", selected.." に設定", 2)
        end
    end,
})

local function AntiInputLagLoop()
    local plr = LocalPlayer
    local SpawnRemote = ReplicatedStorage:FindFirstChild("MenuToys") and ReplicatedStorage.MenuToys:FindFirstChild("SpawnToyRemoteFunction")
    if not SpawnRemote then notify("エラー", "SpawnToyRemoteFunction が見つかりません", 3) return end
    while _G.AntiInputLagRunning do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then task.wait() continue end
        local toysFolder = Workspace:FindFirstChild(plr.Name.."SpawnedInToys")
        if not toysFolder then task.wait() continue end
        local toy = toysFolder:FindFirstChild(_G.AntiInputLagItem)
        if not toy then
            pcall(function() SpawnRemote:InvokeServer(_G.AntiInputLagItem, hrp.CFrame * CFrame.new(0,5,0), Vector3.zero) end)
            task.wait()
            continue
        end
        local holdPart = toy:FindFirstChild("HoldPart")
        if holdPart then
            local holdingPlayer = holdPart:FindFirstChild("HoldingPlayer")
            holdingPlayer = holdingPlayer and holdingPlayer.Value
            if holdingPlayer and holdingPlayer ~= plr then
                pcall(function()
                    if holdPart:FindFirstChild("DropItemRemoteFunction") then
                        holdPart.DropItemRemoteFunction:InvokeServer(toy, hrp.CFrame * CFrame.new(0,2000,0), Vector3.zero)
                    end
                end)
                if toy and toy.Parent then pcall(function() toy:Destroy() end) end
            else
                pcall(function()
                    if holdPart:FindFirstChild("HoldItemRemoteFunction") then
                        holdPart.HoldItemRemoteFunction:InvokeServer(toy, char)
                        task.wait()
                        if holdPart:FindFirstChild("DropItemRemoteFunction") then
                            holdPart.DropItemRemoteFunction:InvokeServer(toy, hrp.CFrame * CFrame.new(0,2000,0), Vector3.zero)
                        end
                    end
                end)
            end
        end
        task.wait()
    end
end

DefenseExtra:AddToggle("AntiInputLagLoopToggle", {
    Text = "アンチ入力ラグ（アイテムループ）",
    Default = false,
    Callback = function(Value)
        _G.AntiInputLagRunning = Value
        if Value then
            if AntiInputLagTask then task.cancel(AntiInputLagTask) AntiInputLagTask = nil end
            AntiInputLagTask = task.spawn(AntiInputLagLoop)
            notify("アンチ入力ラグ", "開始", 2)
        else
            if AntiInputLagTask then task.cancel(AntiInputLagTask) AntiInputLagTask = nil end
            pcall(function()
                local toysFolder = Workspace:FindFirstChild(LocalPlayer.Name.."SpawnedInToys")
                if toysFolder then
                    local toy = toysFolder:FindFirstChild(_G.AntiInputLagItem)
                    if toy then
                        local DestroyToy = ReplicatedStorage:FindFirstChild("MenuToys") and ReplicatedStorage.MenuToys:FindFirstChild("DestroyToy")
                        if DestroyToy then DestroyToy:FireServer(toy) end
                    end
                end
            end)
            notify("アンチ入力ラグ", "停止", 2)
        end
    end,
})

-- Shuriken Anti Kick
local tpActive = false
DefenseExtra:AddToggle("ShurikenAntiKick", {
    Text = "アンチキック",
    Default = false,
    Callback = function(Value)
        _G.ShurikenAntiKick = Value
        local function ClearKunai()
            local plr = game.Players.LocalPlayer
            local inv = workspace:FindFirstChild(plr.Name.."SpawnedInToys")
            local destroyrem = game.ReplicatedStorage:FindFirstChild("MenuToys") and game.ReplicatedStorage.MenuToys:FindFirstChild("DestroyToy")
            if inv and destroyrem then
                for _, v in pairs(inv:GetChildren()) do
                    if v.Name == "AntiKick" or v.Name == "NinjaShuriken" then
                        pcall(function() destroyrem:FireServer(v) end)
                    end
                end
            end
        end
        if Value then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local setOwner = ReplicatedStorage:WaitForChild("GrabEvents"):WaitForChild("SetNetworkOwner")
                local stickyEvent = ReplicatedStorage:WaitForChild("PlayerEvents"):WaitForChild("StickyPartEvent")
                local spawnRemote = ReplicatedStorage.MenuToys.SpawnToyRemoteFunction
                local destroyrem = ReplicatedStorage:WaitForChild("MenuToys"):WaitForChild("DestroyToy")
                local canSpawn = plr:WaitForChild("CanSpawnToy")
                local function getHRP()
                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then return plr.Character.HumanoidRootPart
                    else local character = plr.CharacterAdded:Wait() return character:WaitForChild("HumanoidRootPart") end
                end
                local function CheckForHome()
                    if not workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) then return false end
                    for _, v in pairs(workspace.Plots:GetChildren()) do
                        local sign = v:FindFirstChild("PlotSign")
                        local owners = sign and sign:FindFirstChild("ThisPlotsOwners")
                        if owners then
                            for _, b in pairs(owners:GetChildren()) do
                                if b.Value == plr.Name then
                                    local folder = workspace.PlotItems:FindFirstChild(v.Name)
                                    if folder then return true, folder end
                                end
                            end
                        end
                    end
                    return false
                end
                local function StickKunai(kunai)
                    if not kunai or not kunai:FindFirstChild("StickyPart") then return end
                    local currentHRP = getHRP()
                    if not currentHRP then return end
                    if kunai:FindFirstChild("SoundPart") then
                        if not kunai.SoundPart:FindFirstChild("PartOwner") or kunai.SoundPart.PartOwner.Value ~= plr.Name then
                            setOwner:FireServer(kunai.SoundPart, kunai.SoundPart.CFrame)
                        end
                    end
                    local firePart = currentHRP:FindFirstChild("FirePlayerPart") or currentHRP:WaitForChild("FirePlayerPart", 5)
                    if firePart then
                        stickyEvent:FireServer(kunai.StickyPart, firePart, CFrame.new(0,0,0)*CFrame.Angles(0,math.rad(90),math.rad(90)))
                    end
                    for _, obj in pairs(kunai:GetChildren()) do
                        if obj.Name == "Pyramid" then
                            obj.CanTouch=false; obj.CanCollide=false; obj.CanQuery=false; obj.Transparency=0
                            if not obj:FindFirstChild("Highlight") then
                                local high = Instance.new("Highlight", obj)
                                high.FillColor = Color3.fromRGB(0,0,0)
                            end
                        elseif obj.Name == "Main" then
                            obj.CanTouch=false; obj.CanCollide=false; obj.CanQuery=false; obj.Transparency=0
                            if not obj:FindFirstChild("Highlight") then
                                local high = Instance.new("Highlight", obj)
                                high.FillColor = Color3.fromRGB(255,255,255)
                            end
                        elseif obj:IsA("BasePart") then
                            obj.CanTouch=false; obj.CanCollide=false; obj.CanQuery=false; obj.Transparency=1
                        end
                    end
                end
                local function SpawnToy(name)
                    local t = tick()
                    while not canSpawn.Value do
                        if not _G.ShurikenAntiKick or tick() - t > 5 then return nil end
                        task.wait(0.1)
                    end
                    local currentHRP = getHRP()
                    if currentHRP then
                        task.spawn(function()
                            pcall(function() spawnRemote:InvokeServer(name, currentHRP.CFrame * CFrame.new(0,12,20), Vector3.zero) end)
                        end)
                    end
                    local boolik, house = CheckForHome()
                    local inv = workspace:FindFirstChild(plr.Name.."SpawnedInToys")
                    if boolik and house then return house:WaitForChild(name, 2)
                    elseif not workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) and inv then return inv:WaitForChild(name, 2) end
                    return nil
                end
                while _G.ShurikenAntiKick do
                    task.wait(0.005)
                    if not plr.Character or not plr.Character:FindFirstChild("Humanoid") or plr.Character.Humanoid.Health <= 0 then continue end
                    local inv = workspace:FindFirstChild(plr.Name.."SpawnedInToys")
                    local kunai = inv and inv:FindFirstChild("NinjaShuriken")
                    if workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) then
                        local boolik, house = CheckForHome()
                        if boolik and house and workspace.Plots:FindFirstChild(house.Name) then
                            local sign = workspace.Plots[house.Name]:FindFirstChild("PlotSign")
                            if sign and sign.ThisPlotsOwners.Value.TimeRemainingNum.Value > 89 then
                                kunai = SpawnToy("NinjaShuriken")
                                if kunai == nil then continue end
                                kunai.Name = "AntiKick"
                                StickKunai(kunai)
                            end
                        end
                    end
                    if not kunai then
                        if workspace.PlotItems.PlayersInPlots:FindFirstChild(plr.Name) then continue end
                        kunai = SpawnToy("NinjaShuriken")
                        if kunai == nil then continue end
                        kunai.Name = "AntiKick"
                        if not kunai then continue end
                    end
                    repeat
                        if kunai and kunai:FindFirstChild("StickyPart") and kunai.StickyPart.CanTouch == true then
                            StickKunai(kunai)
                            kunai.Name = "AntiKick"
                        end
                        task.wait(0.3)
                    until not kunai or not _G.ShurikenAntiKick or not kunai:FindFirstChild("StickyPart") or kunai.StickyPart.CanTouch == false or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or not kunai:FindFirstChild("StickyPart") or (plr.Character.HumanoidRootPart.Position - kunai.StickyPart.Position).Magnitude >= 20
                    if not kunai or not kunai:FindFirstChild("StickyPart") or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or (plr.Character.HumanoidRootPart.Position - kunai.StickyPart.Position).Magnitude >= 20 then ClearKunai() end
                    pcall(function()
                        repeat task.wait(0.05) until not _G.ShurikenAntiKick or not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not kunai or not kunai:FindFirstChild("StickyPart") or not kunai.StickyPart:FindFirstChild("StickyWeld") or not kunai.StickyPart.StickyWeld.Part1
                        if not kunai or not kunai:FindFirstChild("StickyPart") or (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health <= 0) or not kunai["StickyPart"]:FindFirstChild("StickyWeld").Part1 then ClearKunai() end
                    end)
                end
            end)
        else
            _G.ShurikenAntiKick = false
            ClearKunai()
        end
    end
})

DefenseExtra:AddToggle("LoopTP", {Text="ループテレポート", Default=false, Callback=function(Value)
    tpActive = Value
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if Value then
        if hum then hum.PlatformStand = true end
        task.spawn(function()
            while tpActive and hrp do
                local x = math.random(-500,500)
                local y = math.random(30,480)
                local z = math.random(-500,500)
                hrp.CFrame = CFrame.new(x,y,z)
                task.wait(0.03)
            end
        end)
    else
        if hum then hum.PlatformStand = false end
    end
end})

-- =====================================================
-- Target Tab (ターゲット) - 全機能
-- =====================================================
local TargetGroup = Tabs.Target:AddLeftGroupbox("🎯 ターゲット操作")
local BlobGroup = Tabs.Target:AddRightGroupbox("👾 ブロブマン操作")
local WhitelistGroup = Tabs.Target:AddRightGroupbox("✅ ホワイトリスト")

local selectedKickPlayer = nil
local kickLoopEnabled = false
local loopKillEnabled = false
local loopKickDualActive = false
local playerFlingActive = false
local flingBAV = nil
local originalPos = nil
local DestroyTargetGucciActive = false
local antiAntiKickActive = false
local antiAntiLagEnabled = false
local updownKickActive = false
local updownKickTask = nil

TargetGroup:AddDropdown("KickPlayerDropdown", {
    Values = getPlayerList(),
    Default = 1,
    Multi = false,
    Text = "ターゲット選択",
    Callback = function(Value) selectedKickPlayer = getPlayerFromSelection(Value) end,
})
TargetGroup:AddButton({Text="🔄 プレイヤーリスト更新", Func=function()
    Options.KickPlayerDropdown:SetValues(getPlayerList())
    Options.KickPlayerDropdown:SetValue(nil)
    selectedKickPlayer = nil
end})

TargetGroup:AddToggle("LoopKickToggle", {
    Text = "キック (グラブ連打)",
    Default = false,
    Callback = function(on)
        kickLoopEnabled = on
        local target = selectedKickPlayer
        if on and not target then if Toggles.LoopKickToggle then Toggles.LoopKickToggle:SetValue(false) end return end
        if not on then kickLoopEnabled = false return end
        task.spawn(function()
            local RS = game:GetService("ReplicatedStorage")
            local RunService = game:GetService("RunService")
            local GE = RS:WaitForChild("GrabEvents")
            local myChar = Player.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end
            local savedPos = myRoot.CFrame
            local dragging = false
            local grabStartTime = 0
            while kickLoopEnabled do
                if not target or not target.Parent then
                    kickLoopEnabled = false
                    if Toggles.LoopKickToggle then Toggles.LoopKickToggle:SetValue(false) end
                    break
                end
                local tChar = target.Character
                local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
                local tHum = tChar and tChar:FindFirstChild("Humanoid")
                myChar = Player.Character
                myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if tRoot and tHum and tHum.Health > 0 and myRoot then
                    tRoot.AssemblyLinearVelocity = Vector3.zero
                    tRoot.AssemblyAngularVelocity = Vector3.zero
                    tRoot.Velocity = Vector3.zero
                    if not dragging then
                        myRoot.CFrame = tRoot.CFrame
                        myRoot.Velocity = Vector3.zero
                        pcall(function()
                            tHum.PlatformStand = true
                            tHum.Sit = true
                            GE.SetNetworkOwner:FireServer(tRoot, myRoot.CFrame)
                            GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        end)
                        if grabStartTime == 0 then grabStartTime = tick() end
                        if tick() - grabStartTime > 0.35 then
                            dragging = true
                            grabStartTime = 0
                        end
                    else
                        myRoot.CFrame = savedPos
                        myRoot.Velocity = Vector3.zero
                        local lockPos = savedPos * CFrame.new(0,17,0)
                        tRoot.CFrame = lockPos
                        tRoot.Velocity = Vector3.zero
                        tRoot.RotVelocity = Vector3.zero
                        tHum.PlatformStand = true
                        tHum.Sit = false
                        pcall(function()
                            GE.SetNetworkOwner:FireServer(tRoot, lockPos)
                            GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                            GE.DestroyGrabLine:FireServer(tRoot)
                            GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        end)
                    end
                else
                    dragging = false
                    grabStartTime = 0
                    if myRoot then myRoot.CFrame = savedPos myRoot.Velocity = Vector3.zero end
                end
                RunService.Heartbeat:Wait()
            end
            if myRoot then myRoot.CFrame = savedPos myRoot.Velocity = Vector3.zero end
        end)
    end
})

TargetGroup:AddToggle("LoopKillToggle", {
    Text = "ループキル",
    Default = false,
    Callback = function(on)
        loopKillEnabled = on
        if on then
            local target = selectedKickPlayer
            if not target then
                notify("システム", "先にターゲットを選択してください", 3)
                Toggles.LoopKickToggle:SetValue(false)
                return
            end
            task.spawn(function()
                local RS = game:GetService("ReplicatedStorage")
                local RunService = game:GetService("RunService")
                local GE = RS:WaitForChild("GrabEvents")
                while loopKillEnabled do
                    if not target or not target.Parent or not target.Character then
                        loopKillEnabled = false
                        Toggles.LoopKillToggle:SetValue(false)
                        break
                    end
                    local myChar = Player.Character
                    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local tChar = target.Character
                    local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
                    local tHum = tChar and tChar:FindFirstChild("Humanoid")
                    if tRoot and tHum and tHum.Health > 0 and myRoot then
                        local currentPos = myRoot.CFrame
                        local attackStart = tick()
                        while tick() - attackStart < 0.35 do
                            if not loopKillEnabled or not tRoot.Parent then break end
                            myRoot.CFrame = tRoot.CFrame * CFrame.new(0,0,2)
                            myRoot.Velocity = Vector3.zero
                            pcall(function()
                                GE.SetNetworkOwner:FireServer(tRoot, myRoot.CFrame)
                                tHum:ChangeState(Enum.HumanoidStateType.Dead)
                                tHum.Health = 0
                                GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                                GE.DestroyGrabLine:FireServer(tRoot)
                            end)
                            RunService.Heartbeat:Wait()
                        end
                        if myRoot then myRoot.CFrame = currentPos myRoot.Velocity = Vector3.zero end
                        task.wait(1.2)
                    else
                        task.wait(0.5)
                    end
                end
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then root.Velocity = Vector3.zero end
            end)
        else
            loopKillEnabled = false
        end
    end
})

TargetGroup:AddToggle("LoopKickToggle", {
    Text = "ループキック (グラブ+ブロブ)",
    Default = false,
    Callback = function(on)
        kickLoopEnabled = on
        local target = selectedKickPlayer
        if on and not target then
            if Toggles.LoopKickToggle then Toggles.LoopKickToggle:SetValue(false) end
            return
        end
        local char = Player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local seat = hum and hum.SeatPart
        if on and (not seat or seat.Parent.Name ~= "CreatureBlobman") then
            if Toggles.LoopKickToggle then Toggles.LoopKickToggle:SetValue(false) end
            return
        end
        if not on then kickLoopEnabled = false return end
        task.spawn(function()
            local RS = game:GetService("ReplicatedStorage")
            local GE = RS:WaitForChild("GrabEvents")
            local RunService = game:GetService("RunService")
            local blob = seat.Parent
            local blobRoot = blob:FindFirstChild("HumanoidRootPart") or blob.PrimaryPart
            local scriptObj = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
            local CG = scriptObj and scriptObj:FindFirstChild("CreatureGrab")
            local CD = scriptObj and scriptObj:FindFirstChild("CreatureDrop")
            local R_Det = blob:FindFirstChild("RightDetector")
            local R_Weld = R_Det and (R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld"))
            local SavedPos = blobRoot.CFrame
            local tChar = target.Character
            local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
            if tRoot and blobRoot then
                local bringStart = tick()
                while tick() - bringStart < 0.35 do
                    if not kickLoopEnabled then break end
                    blobRoot.CFrame = tRoot.CFrame
                    blobRoot.Velocity = Vector3.zero
                    pcall(function()
                        if CG and R_Det then CG:FireServer(R_Det, tRoot, R_Weld) end
                        GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        GE.SetNetworkOwner:FireServer(tRoot, blobRoot.CFrame)
                    end)
                    RunService.Heartbeat:Wait()
                end
                blobRoot.CFrame = SavedPos
                blobRoot.Velocity = Vector3.zero
                task.wait(0.05)
            end
            local packetTimer = 0
            while kickLoopEnabled do
                if not target or not target.Parent or not target.Character then break end
                local tChar = target.Character
                local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
                local tHum = tChar and tChar:FindFirstChild("Humanoid")
                if tRoot and tHum and tHum.Health > 0 and blobRoot then
                    blobRoot.CFrame = SavedPos
                    blobRoot.Velocity = Vector3.zero
                    local lockPos = SavedPos * CFrame.new(0,23,0)
                    tRoot.CFrame = lockPos
                    tRoot.Velocity = Vector3.zero
                    tRoot.RotVelocity = Vector3.zero
                    if tick() - packetTimer > 0.01 then  -- ★★★ 0.05→0.01 ★★★
                        packetTimer = tick()
                        pcall(function()
                            tHum.PlatformStand = true
                            tHum.Sit = true
                            GE.SetNetworkOwner:FireServer(tRoot, lockPos)
                            if R_Det then
                                local weld = R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld")
                                if weld then CD:FireServer(weld) end
                            end
                            GE.DestroyGrabLine:FireServer(tRoot)
                            if R_Det then CG:FireServer(R_Det, tRoot, R_Weld) end
                            GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        end)
                    end
                else
                    blobRoot.CFrame = SavedPos
                    blobRoot.Velocity = Vector3.zero
                end
                if not kickLoopEnabled then break end
                RunService.Heartbeat:Wait()
            end
            kickLoopEnabled = false
            if Toggles.LoopKickToggle then Toggles.LoopKickToggle:SetValue(false) end
            if blobRoot then blobRoot.CFrame = SavedPos blobRoot.Velocity = Vector3.zero end
        end)
    end
})

TargetGroup:AddToggle("DualHandLoopKick", {
    Text = "両手ループキック",
    Default = false,
    Callback = function(on)
        loopKickDualActive = on
        if on then
            if not selectedKickPlayer then
                notify("エラー", "先にターゲットを選択してください", 3)
                Toggles.DualHandLoopKick:SetValue(false)
                return
            end
            task.spawn(function()
                local lastTargetCharDual = nil
                local bp = nil
                while loopKickDualActive do
                    local target = selectedKickPlayer
                    local char = Player.Character
                    local hum = char and char:FindFirstChild("Humanoid")
                    local seat = hum and hum.SeatPart
                    if not seat or not target or not target.Parent then task.wait(0.5) continue end
                    local seatParent = seat.Parent
                    local grab = seatParent:FindFirstChild("BlobmanSeatAndOwnerScript") and seatParent.BlobmanSeatAndOwnerScript:FindFirstChild("CreatureGrab")
                    local drop = seatParent:FindFirstChild("BlobmanSeatAndOwnerScript") and seatParent.BlobmanSeatAndOwnerScript:FindFirstChild("CreatureDrop")
                    if not grab or not drop then task.wait(0.5) continue end
                    local leftDet = seatParent:FindFirstChild("LeftDetector")
                    local rightDet = seatParent:FindFirstChild("RightDetector")
                    local leftWeld = leftDet and leftDet:FindFirstChild("LeftWeld")
                    local rightWeld = rightDet and rightDet:FindFirstChild("RightWeld")
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local targetChar = target.Character
                    local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                    local targetHum = targetChar and targetChar:FindFirstChild("Humanoid")
                    if targetHRP and targetHum and targetHum.Health > 0 then
                        if targetChar ~= lastTargetCharDual then
                            lastTargetCharDual = targetChar
                            if bp then bp:Destroy() bp = nil end
                            if hrp then hrp.CFrame = targetHRP.CFrame * CFrame.new(0,25,0) end
                            task.wait(0.2)
                            grab:FireServer(leftDet, targetHRP, leftWeld)
                            task.wait(0.3)
                            drop:FireServer(leftWeld, targetHRP)
                            task.wait(0.1)
                            bp = Instance.new("BodyPosition")
                            bp.Position = Vector3.new(0,999999,0)
                            bp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                            bp.Parent = targetHRP
                            grab:FireServer(leftDet, targetHRP, leftWeld)
                            task.wait(0.2)
                            drop:FireServer(leftWeld, targetHRP)
                        end
                        grab:FireServer(leftDet, targetHRP, leftWeld)
                        task.wait()
                        drop:FireServer(leftWeld, targetHRP)
                        task.wait()
                        grab:FireServer(rightDet, targetHRP, rightWeld)
                        task.wait()
                        drop:FireServer(rightWeld, targetHRP)
                        task.wait()
                        grab:FireServer(leftDet, targetHRP, leftWeld)
                        grab:FireServer(rightDet, targetHRP, rightWeld)
                        task.wait()
                        drop:FireServer(leftWeld, targetHRP)
                        drop:FireServer(rightWeld, targetHRP)
                        task.wait()
                    else
                        task.wait(0.1)
                    end
                end
                if bp then bp:Destroy() end
            end)
        else
            loopKickDualActive = false
        end
    end
})

TargetGroup:AddToggle("PlayerFlingBtn", {
    Text = "フリング",
    Default = false,
    Callback = function(on)
        playerFlingActive = on
        if on then
            if not selectedKickPlayer then
                notify("システム", "先にターゲットを選択してください", 3)
                Toggles.PlayerFlingBtn:SetValue(false)
                return
            end
            local RunService = game:GetService("RunService")
            local MyChar = Player.Character
            local MyRoot = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
            if MyRoot then originalPos = MyRoot.CFrame end
            notify("フリング", "起動中。動かないでください。", 3)
            task.spawn(function()
                while playerFlingActive do
                    local target = selectedKickPlayer
                    local char = Player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChild("Humanoid")
                    if not hrp or not hum then task.wait(0.5) continue end
                    if target and target.Parent then
                        local tChar = target.Character
                        local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
                        local tHum = tChar and tChar:FindFirstChild("Humanoid")
                        if tRoot and tHum and tHum.Health > 0 then
                            if not flingBAV or flingBAV.Parent ~= hrp then
                                if flingBAV then flingBAV:Destroy() end
                                flingBAV = Instance.new("BodyAngularVelocity")
                                flingBAV.Name = "MaestroSpin"
                                flingBAV.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                                flingBAV.AngularVelocity = Vector3.new(0,10000,0)
                                flingBAV.P = 10000
                                flingBAV.Parent = hrp
                            end
                            for _, part in pairs(char:GetDescendants()) do
                                if part:IsA("BasePart") then part.CanCollide = false end
                            end
                            local loop = RunService.Heartbeat:Connect(function()
                                if not playerFlingActive or not tRoot or not tRoot.Parent then return end
                                hrp.CFrame = tRoot.CFrame
                                hrp.Velocity = Vector3.zero
                            end)
                            local startTime = tick()
                            while tick() - startTime < 1.5 do
                                if not playerFlingActive or not tRoot.Parent then break end
                                task.wait(0.1)
                            end
                            if loop then loop:Disconnect() end
                        else
                            task.wait(0.2)
                        end
                    else
                        playerFlingActive = false
                        Toggles.PlayerFlingBtn:SetValue(false)
                    end
                    task.wait(0.1)
                end
                if flingBAV then flingBAV:Destroy() flingBAV = nil end
                local char = Player.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = true end
                    end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.RotVelocity = Vector3.zero
                        hrp.Velocity = Vector3.zero
                        if originalPos then hrp.CFrame = originalPos end
                    end
                end
            end)
        else
            playerFlingActive = false
            if flingBAV then flingBAV:Destroy() flingBAV = nil end
            local char = Player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.RotVelocity = Vector3.zero hrp.Velocity = Vector3.zero end
        end
    end
})

_G.AutoSitBlobZ = true
BlobGroup:AddToggle("AutoSitZ", {Text="自動着席 [Z]", Default=true, Callback=function(Value) _G.AutoSitBlobZ = Value end})
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Z and _G.AutoSitBlobZ then
        local plr = game.Players.LocalPlayer
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        local folderName = plr.Name .. "SpawnedInToys"
        local folder = workspace:FindFirstChild(folderName)
        local blob = folder and folder:FindFirstChild("CreatureBlobman")
        if not blob then
            task.spawn(function() pcall(function() game.ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer("CreatureBlobman", hrp.CFrame, Vector3.zero) end) end)
            if not folder then folder = workspace:WaitForChild(folderName, 5) end
            if folder then blob = folder:WaitForChild("CreatureBlobman", 5) end
        end
        if blob then
            local seat = blob:WaitForChild("VehicleSeat", 5)
            if seat then
                local t = tick()
                repeat
                    if not hum.SeatPart then
                        hrp.CFrame = seat.CFrame + Vector3.new(0,1,0)
                        hrp.Velocity = Vector3.zero
                        seat:Sit(hum)
                    end
                    game:GetService("RunService").Heartbeat:Wait()
                until hum.SeatPart == seat or tick() - t > 1.5
            end
        end
    end
end)

-- Blob Fly
local blobMasterSwitch = true
local blobFlyActive = false
local bvInstance, bgInstance
local blobFlySpeed = 50
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.R then
        if blobMasterSwitch then
            blobFlyActive = not blobFlyActive
            if not blobFlyActive then
                if bvInstance then bvInstance:Destroy() bvInstance = nil end
                if bgInstance then bgInstance:Destroy() bgInstance = nil end
            end
        end
    end
end)
local function GetBlobRoot()
    local char = Player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum and hum.SeatPart and hum.SeatPart.Parent and hum.SeatPart.Parent.Name == "CreatureBlobman" then
        return hum.SeatPart.Parent:FindFirstChild("HumanoidRootPart") or hum.SeatPart.Parent.PrimaryPart
    end
    local folder = workspace:FindFirstChild(Player.Name.."SpawnedInToys")
    if folder then
        local blob = folder:FindFirstChild("CreatureBlobman")
        if blob then return blob:FindFirstChild("HumanoidRootPart") or blob.PrimaryPart end
    end
    return nil
end
R.Heartbeat:Connect(function()
    if not blobFlyActive or not blobMasterSwitch then
        if bvInstance then bvInstance:Destroy() bvInstance = nil end
        if bgInstance then bgInstance:Destroy() bgInstance = nil end
        return
    end
    local root = GetBlobRoot()
    if root then
        if not root:FindFirstChild("BlobFlyVelocity") then
            bvInstance = Instance.new("BodyVelocity")
            bvInstance.Name = "BlobFlyVelocity"
            bvInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bvInstance.P = 10000
            bvInstance.Parent = root
        else bvInstance = root.BlobFlyVelocity end
        if not root:FindFirstChild("BlobFlyGyro") then
            bgInstance = Instance.new("BodyGyro")
            bgInstance.Name = "BlobFlyGyro"
            bgInstance.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bgInstance.P = 20000
            bgInstance.D = 100
            bgInstance.Parent = root
        else bgInstance = root.BlobFlyGyro end
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end
        if bvInstance then bvInstance.Velocity = moveDir * blobFlySpeed end
        if bgInstance then bgInstance.CFrame = cam.CFrame end
    else
        if bvInstance then bvInstance:Destroy() bvInstance = nil end
        if bgInstance then bgInstance:Destroy() bgInstance = nil end
    end
end)

TargetGroup:AddToggle("DestroyTargetGucci", {
    Text = "グッチ破壊 (着席)",
    Default = false,
    Callback = function(Value)
        DestroyTargetGucciActive = Value
        if Value then
            if not selectedKickPlayer then
                notify("エラー", "ターゲットを選択してください", 3)
                Toggles.DestroyTargetGucci:SetValue(false)
                return
            end
            local char = Player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local SafeSpot = root.CFrame
            local RunService = game:GetService("RunService")
            local folderName = selectedKickPlayer.Name .. "SpawnedInToys"
            notify("システム", "フォルダ待機中: " .. folderName, 3)
            task.spawn(function()
                while DestroyTargetGucciActive do
                    if not selectedKickPlayer or not selectedKickPlayer.Parent then
                        notify("システム", "プレイヤーが退出しました", 3)
                        DestroyTargetGucciActive = false
                        Toggles.DestroyTargetGucci:SetValue(false)
                        break
                    end
                    local toysFolder = workspace:FindFirstChild(folderName)
                    if not toysFolder then task.wait(1) else
                        local foundBlob = false
                        for _, obj in ipairs(toysFolder:GetChildren()) do
                            if not DestroyTargetGucciActive then break end
                            if obj.Name == "CreatureBlobman" then
                                foundBlob = true
                                local seat = obj:FindFirstChild("VehicleSeat") or obj:FindFirstChildWhichIsA("VehicleSeat", true)
                                if seat then
                                    local myChar = Player.Character
                                    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                                    local myHum = myChar and myChar:FindFirstChild("Humanoid")
                                    if myRoot and myHum then
                                        if myHum.SeatPart ~= seat then
                                            notify("ターゲット", "破壊中", 1)
                                            local magnetConnection
                                            magnetConnection = RunService.Stepped:Connect(function()
                                                if myRoot and seat then
                                                    myRoot.CFrame = seat.CFrame
                                                    myRoot.Velocity = Vector3.zero
                                                    if obj.PrimaryPart then
                                                        obj.PrimaryPart.Velocity = Vector3.zero
                                                        obj.PrimaryPart.RotVelocity = Vector3.zero
                                                    end
                                                end
                                            end)
                                            local sitStart = tick()
                                            while tick() - sitStart < 1 do
                                                if not DestroyTargetGucciActive then break end
                                                if myHum.SeatPart == seat then break end
                                                seat:Sit(myHum)
                                                task.wait()
                                            end
                                            if magnetConnection then magnetConnection:Disconnect() end
                                            if myHum.SeatPart == seat then
                                                task.wait(0.3)
                                                myHum.Sit = false
                                                myHum.Jump = true
                                                task.wait(0.05)
                                                myRoot.CFrame = SafeSpot
                                                myRoot.Velocity = Vector3.zero
                                                notify("成功", "破壊完了", 1)
                                                task.wait(0.5)
                                            else
                                                myRoot.CFrame = SafeSpot
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            DestroyTargetGucciActive = false
            notify("システム", "グッチ破壊 停止", 2)
        end
    end
})

TargetGroup:AddButton({
    Text = "引き寄せ",
    Func = function()
        if not selectedKickPlayer then return end
        local char = Player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local seat = hum and hum.SeatPart
        if not seat or seat.Parent.Name ~= "CreatureBlobman" then return end
        local blob = seat.Parent
        local blobRoot = blob:FindFirstChild("HumanoidRootPart")
        local scriptObj = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
        if not blobRoot or not scriptObj then return end
        local CG = scriptObj:FindFirstChild("CreatureGrab")
        local CD = scriptObj:FindFirstChild("CreatureDrop")
        local R_Det = blob:FindFirstChild("RightDetector")
        local R_Weld = R_Det and R_Det:FindFirstChild("RightWeld")
        local tChar = selectedKickPlayer.Character
        local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if not tRoot then return end
        local home = blobRoot.CFrame
        blobRoot.CFrame = tRoot.CFrame
        blobRoot.Velocity = Vector3.new()
        blobRoot.RotVelocity = Vector3.new()
        task.wait(0.3)
        pcall(function() CG:FireServer(R_Det, tRoot, R_Weld) end)
        task.wait(0.5)
        blobRoot.CFrame = home
        blobRoot.Velocity = Vector3.new()
        blobRoot.RotVelocity = Vector3.new()
        task.wait(0.05)
        for i = 1, 12 do
            tRoot.CFrame = home * CFrame.new(0,3,0)
            tRoot.Velocity = Vector3.new()
            tRoot.RotVelocity = Vector3.new()
            task.wait(0.03)
        end
        for i = 1, 8 do
            local weld = R_Det:FindFirstChild("RightWeld")
            if weld then pcall(function() CD:FireServer(weld) end) end
            task.wait(0.03)
        end
    end
})

TargetGroup:AddToggle("DestroyAntiKickToggle", {
    Text = "アンチキック奪取",
    Default = false,
    Callback = function(Value)
        antiAntiKickActive = Value
        if Value then
            task.spawn(function()
                local SetNetOwner = game:GetService("ReplicatedStorage").GrabEvents.SetNetworkOwner
                local LocalPlayer = game.Players.LocalPlayer
                local function invis_touch(part, cf) SetNetOwner:FireServer(part, cf) end
                local function CheckAndYeet(toy)
                    local part = toy:FindFirstChild("SoundPart")
                    if part then
                        invis_touch(part, part.CFrame)
                        if part:FindFirstChild("PartOwner") and part.PartOwner.Value == LocalPlayer.Name then
                            part.CFrame = CFrame.new(0,1000,0)
                        end
                    end
                end
                while antiAntiKickActive do
                    local target = selectedKickPlayer
                    if target then
                        local spawned = workspace:FindFirstChild(target.Name.."SpawnedInToys")
                        if spawned then
                            if spawned:FindFirstChild("NinjaKunai") then CheckAndYeet(spawned.NinjaKunai) end
                            if spawned:FindFirstChild("NinjaShuriken") then CheckAndYeet(spawned.NinjaShuriken) end
                            if spawned:FindFirstChild("AntiKick") then CheckAndYeet(spawned.AntiKick) end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            antiAntiKickActive = false
        end
    end
})

TargetGroup:AddToggle("AntiAntiInputLag", {
    Text = "アンチ入力ラグ対策",
    Default = false,
    Callback = function(on)
        antiAntiLagEnabled = on
        if not on then antiAntiLagEnabled = false return end
        task.spawn(function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local burgers = {}
            for _, v in ipairs(workspace:GetDescendants()) do
                if v.Name == "FoodHamburger" and v:IsA("Model") and v:FindFirstChild("HoldPart") then
                    burgers[#burgers+1] = v
                end
            end
            workspace.DescendantAdded:Connect(function(obj)
                if obj.Name == "FoodHamburger" and obj:IsA("Model") then
                    task.spawn(function()
                        local hp = obj:WaitForChild("HoldPart", 3)
                        if hp then burgers[#burgers+1] = obj end
                    end)
                end
            end)
            while antiAntiLagEnabled do
                for i = #burgers, 1, -1 do
                    local b = burgers[i]
                    if not b or not b.Parent or not b:FindFirstChild("HoldPart") then
                        table.remove(burgers, i)
                    else
                        local hp = b.HoldPart
                        pcall(function() hp.HoldItemRemoteFunction:InvokeServer(b, char) end)
                        task.wait()
                        pcall(function() hp.DropItemRemoteFunction:InvokeServer(b, CFrame.new(hrp.Position + Vector3.new(0,-2000,0)), Vector3.zero) end)
                    end
                end
                task.wait()
            end
        end)
    end
})

-- ========== 上下キック ==========
local updownKickToggle = BlobGroup:AddToggle("UpDownKick", {
    Text = "上下キック",
    Default = false,
    Callback = function(on)
        updownKickActive = on
        if not on then
            if updownKickTask then
                task.cancel(updownKickTask)
                updownKickTask = nil
            end
            return
        end
        if not selectedKickPlayer then
            notify("エラー", "先にターゲットを選択してください", 3)
            updownKickToggle:SetValue(false)
            updownKickActive = false
            return
        end
        local function mountBlobman()
            local char = Player.Character
            if not char then return false end
            local hum = char:FindFirstChild("Humanoid")
            if not hum then return false end
            if hum.SeatPart and hum.SeatPart.Parent and hum.SeatPart.Parent.Name == "CreatureBlobman" then
                return true
            end
            local blob = nil
            local folderName = Player.Name .. "SpawnedInToys"
            local folder = workspace:FindFirstChild(folderName)
            if folder then
                blob = folder:FindFirstChild("CreatureBlobman")
            end
            if not blob then
                pcall(function()
                    game.ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer("CreatureBlobman", char.HumanoidRootPart.CFrame, Vector3.zero)
                end)
                if not folder then
                    folder = workspace:WaitForChild(folderName, 5)
                end
                if folder then
                    blob = folder:WaitForChild("CreatureBlobman", 5)
                end
            end
            if not blob then return false end
            local seat = blob:FindFirstChild("VehicleSeat") or blob:FindFirstChildWhichIsA("Seat")
            if not seat then return false end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = seat.CFrame + Vector3.new(0,1,0)
                root.Velocity = Vector3.zero
                seat:Sit(hum)
                local t = tick()
                repeat
                    task.wait(0.05)
                until hum.SeatPart == seat or tick() - t > 1.5
                return hum.SeatPart == seat
            end
            return false
        end

        if not mountBlobman() then
            notify("エラー", "ブロブマンに乗れませんでした", 3)
            updownKickToggle:SetValue(false)
            updownKickActive = false
            return
        end

        updownKickTask = task.spawn(function()
            local char = Player.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local seat = hum and hum.SeatPart
            if not seat or seat.Parent.Name ~= "CreatureBlobman" then
                notify("エラー", "ブロブマンに乗っていません", 3)
                updownKickActive = false
                updownKickToggle:SetValue(false)
                return
            end
            local GE = ReplicatedStorage:WaitForChild("GrabEvents")
            local blob = seat.Parent
            local blobRoot = blob:FindFirstChild("HumanoidRootPart") or blob.PrimaryPart
            local scriptObj = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
            local CG = scriptObj and scriptObj:FindFirstChild("CreatureGrab")
            local CD = scriptObj and scriptObj:FindFirstChild("CreatureDrop")
            local R_Det = blob:FindFirstChild("RightDetector")
            local R_Weld = R_Det and (R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld"))
            if not blobRoot or not CG or not CD or not R_Det or not R_Weld then
                notify("エラー", "ブロブマンに必要なパーツがありません", 3)
                updownKickActive = false
                updownKickToggle:SetValue(false)
                return
            end
            local SavedPos = blobRoot.CFrame
            local target = selectedKickPlayer
            local tChar = target.Character
            local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
            if tRoot and blobRoot then
                local bringStart = tick()
                while tick() - bringStart < 0.15 do
                    if not updownKickActive then break end
                    blobRoot.CFrame = tRoot.CFrame
                    blobRoot.Velocity = Vector3.zero
                    pcall(function()
                        CG:FireServer(R_Det, tRoot, R_Weld)
                        GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        GE.SetNetworkOwner:FireServer(tRoot, blobRoot.CFrame)
                    end)
                    RunService.Heartbeat:Wait()
                end
                blobRoot.CFrame = SavedPos
                blobRoot.Velocity = Vector3.zero
                task.wait(0.05)
            end

            local packetTimer = 0
            local cycleTime = 0.02

            while updownKickActive do
                if not target or not target.Parent or not target.Character then break end
                if not blobRoot or not blobRoot.Parent then break end
                tChar = target.Character
                tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
                local tHum = tChar and tChar:FindFirstChild("Humanoid")
                if tRoot and tHum and tHum.Health > 0 then
                    blobRoot.CFrame = SavedPos
                    blobRoot.Velocity = Vector3.zero
                    local phase = math.floor(tick() / cycleTime) % 2
                    local offsetY = (phase == 0) and 12 or -5
                    local lockPos = SavedPos * CFrame.new(0, offsetY, -5)
                    tRoot.CFrame = lockPos
                    tRoot.Velocity = Vector3.zero
                    tRoot.RotVelocity = Vector3.zero
                    if tick() - packetTimer > 0.01 then  -- ★★★ 0.05→0.01 ★★★
                        packetTimer = tick()
                        pcall(function()
                            tHum.PlatformStand = true
                            tHum.Sit = true
                            GE.SetNetworkOwner:FireServer(tRoot, lockPos)
                            if R_Det then
                                local weld = R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld")
                                if weld then
                                    CD:FireServer(weld)
                                end
                            end
                            GE.DestroyGrabLine:FireServer(tRoot)
                            CG:FireServer(R_Det, tRoot, R_Weld)
                            GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        end)
                    end
                else
                    if blobRoot and blobRoot.Parent then
                        blobRoot.CFrame = SavedPos
                        blobRoot.Velocity = Vector3.zero
                    end
                end
                RunService.Heartbeat:Wait()
            end
            updownKickActive = false
            if updownKickToggle then updownKickToggle:SetValue(false) end
            if blobRoot and blobRoot.Parent then
                blobRoot.CFrame = SavedPos
                blobRoot.Velocity = Vector3.zero
            end
        end)
    end
})

WhitelistGroup:AddDropdown("MultiWhitelist", {Values = getPlayerList(), Default = {}, Multi = true, Text = "ホワイトリスト"})
WhitelistGroup:AddButton({Text = "🔄 リスト更新", Func = function() Options.MultiWhitelist:SetValues(getPlayerList()) end})

local notifyActive = false
local notifyConnection = nil
WhitelistGroup:AddToggle("JoinedNotifyBtn", {
    Text = "ターゲット参加通知",
    Default = false,
    Callback = function(on)
        notifyActive = on
        if on then
            notify("レーダー", "ターゲット監視中...", 3)
            if notifyConnection then notifyConnection:Disconnect() end
            notifyConnection = PS.PlayerAdded:Connect(function(newPlayer)
                if not notifyActive then return end
                local detected = false
                local reason = ""
                local whitelistTable = Options.MultiWhitelist.Value
                for nameString, isSelected in pairs(whitelistTable) do
                    if isSelected then
                        local actualName = nameString:match("%((.-)%)")
                        if actualName == newPlayer.Name then
                            detected = true
                            reason = "[ホワイトリスト]"
                            break
                        end
                    end
                end
                if not detected and Options.KickPlayerDropdown and Options.KickPlayerDropdown.Value then
                    local selection = Options.KickPlayerDropdown.Value
                    local selectedName = selection:match("%((.-)%)")
                    if selectedName and selectedName == newPlayer.Name then
                        detected = true
                        reason = "[メインターゲット]"
                    end
                end
                if detected then
                    notify("ターゲット参加", reason .. " プレイヤー: " .. newPlayer.Name, 8)
                    local sound = Instance.new("Sound", workspace)
                    sound.SoundId = "rbxassetid://4590662766"
                    sound.Volume = 2
                    sound:Play()
                    game:GetService("Debris"):AddItem(sound, 3)
                end
            end)
        else
            if notifyConnection then notifyConnection:Disconnect() notifyConnection = nil end
            notify("レーダー", "監視停止", 2)
        end
    end
})

-- =====================================================
-- Grab Tab (掴み) - 全機能
-- =====================================================
local GrabGroup = Tabs.Grab:AddLeftGroupbox("✋ 掴みカスタマイズ")
_G.strength = 750
local strengthConnection
GrabGroup:AddSlider("ThrowPowerSlider", {Text="投擲力", Default=750, Min=1, Max=20000, Rounding=0, Callback=function(value) _G.strength = value end})
GrabGroup:AddToggle("ThrowStrengthToggle", {Text="投擲強化", Default=false, Callback=function(enabled)
    if enabled then
        strengthConnection = workspace.ChildAdded:Connect(function(model)
            if model.Name == "GrabParts" then
                local partToImpulse = model.GrabPart.WeldConstraint.Part1
                if partToImpulse then
                    local velocityObj = Instance.new("BodyVelocity", partToImpulse)
                    model:GetPropertyChangedSignal("Parent"):Connect(function()
                        if not model.Parent then
                            if UserInputService:GetLastInputType() == Enum.UserInputType.MouseButton2 then
                                velocityObj.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                velocityObj.Velocity = workspace.CurrentCamera.CFrame.LookVector * _G.strength
                                game:GetService("Debris"):AddItem(velocityObj, 1)
                            else
                                velocityObj:Destroy()
                            end
                        end
                    end)
                end
            end
        end)
    elseif strengthConnection then strengthConnection:Disconnect() end
end})

local killGrabEnabled = false
local function killGrabFunction()
    workspace.ChildAdded:Connect(function(v)
        if v:IsA("Model") and v.Name == "GrabParts" and killGrabEnabled then
            task.wait(0.05)
            local grabPart = v:FindFirstChild("GrabPart")
            if grabPart and grabPart:FindFirstChild("WeldConstraint") then
                local part1 = grabPart.WeldConstraint.Part1
                if part1 and part1.Parent and part1.Parent ~= Player.Character then
                    local targetChar = part1.Parent
                    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
                    if targetHum and targetChar then
                        pcall(function() targetHum.Health = 0 targetChar:BreakJoints() end)
                    end
                end
            end
        end
    end)
end
killGrabFunction()
GrabGroup:AddToggle("KillGrabToggle", {Text="キルグラブ", Default=false, Callback=function(Value) killGrabEnabled = Value end})

-- =====================================================
-- Player Tab (プレイヤー) - 全機能
-- =====================================================
local PlayerView = Tabs.Player:AddLeftGroupbox("👤 視点＆移動")
local PlayerESP = Tabs.Player:AddRightGroupbox("🌈 ESP")
local PlayerPerf = Tabs.Player:AddRightGroupbox("⚡ パフォーマンス")

local function enableThirdPerson()
    Player.CameraMode = Enum.CameraMode.Classic
    Camera.CameraType = Enum.CameraType.Custom
    Camera.CameraSubject = Player.Character:WaitForChild("Humanoid")
    Player.CameraMaxZoomDistance = 999999
    Player.CameraMinZoomDistance = 0.5
end
local function disableThirdPerson()
    Player.CameraMode = Enum.CameraMode.LockFirstPerson
    Camera.CameraType = Enum.CameraType.Custom
    Camera.CameraSubject = Player.Character:WaitForChild("Humanoid")
    Player.CameraMaxZoomDistance = 0
    Player.CameraMinZoomDistance = 0
end
PlayerView:AddToggle("ThirdPersonToggle", {Text="三人称視点", Default=false, Callback=function(Value) if Value then enableThirdPerson() else disableThirdPerson() end end})

local spinningConnection
local spinSpeed = 5
PlayerView:AddToggle("SpinToggle", {Text="回転", Default=false, Callback=function(Value)
    if Value then
        spinningConnection = R.Heartbeat:Connect(function()
            local character = Player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if root then root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0) end
        end)
    else
        if spinningConnection then spinningConnection:Disconnect() spinningConnection = nil end
    end
end})
PlayerView:AddSlider("SpinSpeed", {Text="回転速度", Default=5, Min=1, Max=50, Rounding=0, Callback=function(Value) spinSpeed = Value end})

local infJump = false
PlayerView:AddToggle("infJumpToggle", {Text="無限ジャンプ", Default=false, Callback=function(Value) infJump = Value end})
UserInputService.JumpRequest:Connect(function()
    if infJump then
        local character = Player.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Rainbow ESP
local RainbowESP = {Enabled=false, Boxes={}, Connections={}, Hue=0, Speed=0.5, Transparency=0.3, UpdateInterval=0.05}
local function GetRainbowColor() return Color3.fromHSV(RainbowESP.Hue,1,1) end
task.spawn(function()
    while true do
        if RainbowESP.Enabled then
            RainbowESP.Hue = (RainbowESP.Hue + 0.005 * RainbowESP.Speed) % 1
            for _, box in pairs(RainbowESP.Boxes) do
                if box and box.Parent then pcall(function() box.Color3 = GetRainbowColor() end) end
            end
        end
        task.wait(RainbowESP.UpdateInterval)
    end
end)
local targetNames = {"partesp", "playercharacterlocationdetector"}
local function IsTarget(obj)
    if not obj:IsA("BasePart") then return false end
    for _, name in ipairs(targetNames) do
        if string.lower(obj.Name) == string.lower(name) then return true end
    end
    return false
end
local function RemoveAllRainbowBoxes()
    for obj, box in pairs(RainbowESP.Boxes) do if box then pcall(function() box:Destroy() end) end end
    RainbowESP.Boxes = {}
    for _, conn in ipairs(RainbowESP.Connections) do if conn and conn.Connected then pcall(function() conn:Disconnect() end) end end
    RainbowESP.Connections = {}
end
PlayerESP:AddToggle("BoxESPWhite", {
    Text = "🌈 レインボーESP",
    Default = false,
    Callback = function(Value)
        RainbowESP.Enabled = Value
        if Value then
            RemoveAllRainbowBoxes()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if RainbowESP.Enabled and IsTarget(obj) then
                    if not RainbowESP.Boxes[obj] then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Adornee = obj
                        box.AlwaysOnTop = true
                        box.ZIndex = 5
                        box.Color3 = GetRainbowColor()
                        box.Transparency = RainbowESP.Transparency
                        box.Size = obj.Size
                        box.Parent = game.CoreGui
                        RainbowESP.Boxes[obj] = box
                    end
                end
            end
            local descConn = workspace.DescendantAdded:Connect(function(obj)
                if RainbowESP.Enabled and IsTarget(obj) then
                    if not RainbowESP.Boxes[obj] then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Adornee = obj
                        box.AlwaysOnTop = true
                        box.ZIndex = 5
                        box.Color3 = GetRainbowColor()
                        box.Transparency = RainbowESP.Transparency
                        box.Size = obj.Size
                        box.Parent = game.CoreGui
                        RainbowESP.Boxes[obj] = box
                    end
                end
            end)
            table.insert(RainbowESP.Connections, descConn)
        else
            RemoveAllRainbowBoxes()
        end
    end
})

local rainbowNicknames = {}
PlayerESP:AddToggle("NicknameESP", {
    Text = "🌈 ニックネームESP",
    Default = false,
    Callback = function(Value)
        if Value then
            local function createRainbowESP(plr)
                if plr == Player then return end
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = plr.Character.HumanoidRootPart
                    if hrp:FindFirstChild("RainbowNameESP") then hrp.RainbowNameESP:Destroy() end
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "RainbowNameESP"
                    billboard.Adornee = hrp
                    billboard.Size = UDim2.new(0,150,0,40)
                    billboard.StudsOffset = Vector3.new(0,3.5,0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = hrp
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1,0,1,0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = plr.DisplayName
                    textLabel.TextColor3 = GetRainbowColor()
                    textLabel.TextStrokeTransparency = 0
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.GothamBold
                    textLabel.Parent = billboard
                    table.insert(rainbowNicknames, billboard)
                    task.spawn(function()
                        while billboard and billboard.Parent do
                            task.wait(0.1)
                            if textLabel and textLabel.Parent then
                                pcall(function() textLabel.TextColor3 = GetRainbowColor() end)
                            end
                        end
                    end)
                end
            end
            for _, plr in pairs(PS:GetPlayers()) do
                createRainbowESP(plr)
                plr.CharacterAdded:Connect(function() createRainbowESP(plr) end)
            end
            PS.PlayerAdded:Connect(function(plr)
                plr.CharacterAdded:Connect(function() createRainbowESP(plr) end)
            end)
        else
            for _, gui in pairs(rainbowNicknames) do if gui then pcall(function() gui:Destroy() end) end end
            rainbowNicknames = {}
            for _, plr in pairs(PS:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = plr.Character.HumanoidRootPart
                    if hrp:FindFirstChild("RainbowNameESP") then pcall(function() hrp.RainbowNameESP:Destroy() end) end
                end
            end
        end
    end
})

-- FPS Boost
local oldProperties = {}
PlayerPerf:AddButton({Text="🚀 FPSブースト", Func=function()
    local Lighting = game:GetService("Lighting")
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if not oldProperties[v] then oldProperties[v] = {Material = v.Material, Reflectance = v.Reflectance, CastShadow = v.CastShadow} end
            v.Material = Enum.Material.Plastic v.Reflectance = 0 v.CastShadow = false
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            if not oldProperties[v] then oldProperties[v] = {Enabled = v.Enabled} end
            v.Enabled = false
        end
    end
    for _, plr in pairs(PS:GetPlayers()) do
        if plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    if not oldProperties[part] then oldProperties[part] = {Material = part.Material, Reflectance = part.Reflectance, CastShadow = part.CastShadow} end
                    part.Material = Enum.Material.Plastic part.Reflectance = 0 part.CastShadow = false
                end
            end
        end
    end
    if not oldProperties["Lighting"] then oldProperties["Lighting"] = {GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd, Brightness = Lighting.Brightness} end
    Lighting.GlobalShadows = false Lighting.FogEnd = 100000 Lighting.Brightness = 2
end})
PlayerPerf:AddButton({Text="↩️ FPSブースト解除", Func=function()
    local Lighting = game:GetService("Lighting")
    for obj, props in pairs(oldProperties) do
        if typeof(obj) == "Instance" and obj.Parent then
            for prop, value in pairs(props) do obj[prop] = value end
        elseif obj == "Lighting" then
            for prop, value in pairs(props) do Lighting[prop] = value end
        end
    end
    oldProperties = {}
end})

-- =====================================================
-- Misc Tab (その他) - 全機能
-- =====================================================
local MiscGroup = Tabs.Misc:AddLeftGroupbox("📦 その他機能")
local mouse = Player:GetMouse()
local tpToolConn
MiscGroup:AddToggle("TPToggle", {Text="テレポート [T]", Default=false, Callback=function(Value)
    if Value then
        if tpToolConn then tpToolConn:Disconnect() end
        tpToolConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.T then
                local character = Player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local hrp = character.HumanoidRootPart
                    local targetPos = mouse.Hit.Position
                    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,3,0))
                end
            end
        end)
    else
        if tpToolConn then tpToolConn:Disconnect() tpToolConn = nil end
    end
end})

local waterParts = {}
task.spawn(function()
    if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("AlwaysHereTweenedObjects") then
        local oceanModel = workspace.Map.AlwaysHereTweenedObjects.Ocean.Object.ObjectModel
        for _, v in pairs(oceanModel:GetChildren()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("BasePart") or v:IsA("MeshPart") then
                table.insert(waterParts, {part = v, originalCollide = v.CanCollide})
            end
        end
    end
end)
MiscGroup:AddToggle("WaterWalkToggle", {Text="水上歩行", Default=false, Callback=function(on)
    for _, item in pairs(waterParts) do if item.part then item.part.CanCollide = on end end
end})

-- Triggerbot
local Triggerbot = {Enabled=false, Connection=nil, canGrab=true, maxDistance=20, preGrabDelay=0.00001, postGrabDelay=0.05, lastTarget=nil, lastHitTime=0, targetMemoryDuration=0.1, checkThrottle=0.008, lastCheck=0}
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
task.spawn(function()
    local success, result = pcall(function() return RS.GamepassEvents.CheckForGamepass:InvokeServer(20837132) end)
    if success and result then Triggerbot.maxDistance = 29.3 end
end)
if RS:FindFirstChild("GamepassEvents") and RS.GamepassEvents:FindFirstChild("FurtherReachBoughtNotifier") then
    RS.GamepassEvents.FurtherReachBoughtNotifier.OnClientEvent:Connect(function() Triggerbot.maxDistance = 29.3 end)
end
function Triggerbot:GetTarget()
    local c = Player.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    if Workspace:FindFirstChild("GrabParts") then return end
    local origin, dir = Camera.CFrame.Position, Camera.CFrame.LookVector
    rayParams.FilterDescendantsInstances = {c, Workspace.Terrain}
    local result = Workspace:Raycast(origin, dir * 1000, rayParams)
    if not result then
        local dirs = {dir, (dir + Vector3.new(0,0.075,0)).Unit, (dir - Vector3.new(0,0.075,0)).Unit}
        for _, d in ipairs(dirs) do
            result = Workspace:Raycast(origin, d * 1000, rayParams)
            if result then break end
        end
    end
    if not result then return end
    local hit = result.Instance
    local model = hit:FindFirstAncestorOfClass("Model")
    if not model or not model:FindFirstChildOfClass("Humanoid") or model == c then return end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if hum.Health <= 0 then return end
    local root = model:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local dist = (c.HumanoidRootPart.Position - root.Position).Magnitude
    if dist > self.maxDistance then return end
    return model
end
function Triggerbot:OnHeartbeat()
    if not self.Enabled or not self.canGrab then return end
    if UserInputService:GetFocusedTextBox() then return end
    if tick() - self.lastCheck < self.checkThrottle then return end
    self.lastCheck = tick()
    local t = self:GetTarget()
    if t then self.lastTarget = t self.lastHitTime = tick()
    elseif self.lastTarget and tick() - self.lastHitTime > self.targetMemoryDuration then self.lastTarget = nil end
    local c = Player.Character
    local root = self.lastTarget and self.lastTarget:FindFirstChild("HumanoidRootPart")
    if not (self.lastTarget and c and c:FindFirstChild("HumanoidRootPart") and root) then return end
    if (c.HumanoidRootPart.Position - root.Position).Magnitude > self.maxDistance then self.lastTarget = nil return end
    if self.lastTarget then
        self.canGrab = false
        task.spawn(function()
            task.wait(self.preGrabDelay)
            pcall(mouse1press)
            local t0 = tick()
            repeat task.wait(0.02) until not Workspace:FindFirstChild("GrabParts") or tick() - t0 > 1.6
            task.wait(self.postGrabDelay)
            self.canGrab = true
            self.lastTarget = nil
        end)
    end
end
MiscGroup:AddToggle("TriggerbotToggle", {Text="トリガーボット", Default=Triggerbot.Enabled, Callback=function(value)
    Triggerbot.Enabled = value
    if Triggerbot.Enabled and not Triggerbot.Connection then
        Triggerbot.Connection = R.Heartbeat:Connect(function() Triggerbot:OnHeartbeat() end)
    elseif not Triggerbot.Enabled and Triggerbot.Connection then
        Triggerbot.Connection:Disconnect()
        Triggerbot.Connection = nil
    end
end})

-- Packet Lag
local PacketSpamAmount = 100
MiscGroup:AddSlider("PacketAmountSlider", {Text="パケット量", Default=100, Min=10, Max=5000, Rounding=0, Callback=function(Value) PacketSpamAmount = Value end})
MiscGroup:AddToggle("PacketLagToggle", {Text="パケットラグ", Default=false, Callback=function(Value)
    _G.PacketLagActive = Value
    if Value then
        task.spawn(function()
            for i, e in pairs(game.Players:GetPlayers()) do if e.Name == "MaybeFlashh" then return end end
            local RS = game:GetService("ReplicatedStorage")
            local GrabEvent = RS:WaitForChild("GrabEvents"):WaitForChild("ExtendGrabLine")
            while _G.PacketLagActive do
                pcall(function() GrabEvent:FireServer(string.rep("Balls Balls Balls Balls", PacketSpamAmount)) end)
                task.wait()
            end
        end)
    else
        _G.PacketLagActive = false
    end
end})

local autoResetEnabled = false
MiscGroup:AddToggle("AutoResetToggle", {Text="自動リセット", Default=false, Callback=function(on)
    autoResetEnabled = on
    if not on then autoResetEnabled = false return end
    task.spawn(function()
        local plr = game.Players.LocalPlayer
        while autoResetEnabled do
            local char = plr.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then hum.Health = 0 end
            task.wait(0.5)
        end
    end)
end})

MiscGroup:AddSlider("FOVSlider", {Text="視野角(FOV)", Default=90, Min=1, Max=120, Rounding=0, Suffix="°", Callback=function(value) game.Workspace.CurrentCamera.FieldOfView = value end})

-- Heart Sparkler
local heartHighRun = false
local heartConnection = nil
local heartToy = nil
MiscGroup:AddToggle("HeartSparklerHigh", {Text="💖 ハート", Default=false, Callback=function(Value)
    heartHighRun = Value
    if Value then
        task.spawn(function()
            if not Player.Character then return end
            local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            pcall(function() RS.MenuToys.SpawnToyRemoteFunction:InvokeServer("FireworkSparkler", hrp.CFrame * CFrame.new(0,50,0), Vector3.zero) end)
            local folderName = Player.Name.."SpawnedInToys"
            local folder = workspace:WaitForChild(folderName, 5)
            if not folder then return end
            heartToy = folder:WaitForChild("FireworkSparkler", 5)
            if not heartToy then return end
            local part = heartToy:FindFirstChild("Handle") or heartToy:FindFirstChildWhichIsA("BasePart")
            if not part then return end
            task.wait(0.2)
            for _, v in pairs(heartToy:GetDescendants()) do
                if v:IsA("BasePart") then v.Anchored = false v.CanCollide = false v.Massless = true end
            end
            part:BreakJoints()
            local bp = Instance.new("BodyPosition")
            bp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            bp.P = 20000
            bp.D = 500
            bp.Parent = part
            local bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
            bg.P = 3000
            bg.CFrame = CFrame.new()
            bg.Parent = part
            local t = 0
            if heartConnection then heartConnection:Disconnect() end
            heartConnection = RunService.Heartbeat:Connect(function(dt)
                if not heartHighRun or not part or not part.Parent then
                    if heartConnection then heartConnection:Disconnect() end
                    if heartToy then pcall(function() heartToy:Destroy() end) end
                    return
                end
                local currentHrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                if not currentHrp then return end
                pcall(function() RS.GrabEvents.SetNetworkOwner:FireServer(part, part.CFrame) end)
                t = t + (8 * dt)
                local scale = 1.5
                local x = 16 * math.sin(t)^3
                local y = 13 * math.cos(t) - 5 * math.cos(2*t) - 2 * math.cos(3*t) - math.cos(4*t)
                local relPos = Vector3.new(x*scale, (y*scale)+25, 3)
                local finalPos = currentHrp.CFrame:PointToWorldSpace(relPos)
                bp.Position = finalPos
                bg.CFrame = currentHrp.CFrame
            end)
        end)
    else
        if heartConnection then heartConnection:Disconnect() heartConnection = nil end
        if heartToy then pcall(function() heartToy:Destroy() end) heartToy = nil end
    end
end})

-- =====================================================
-- Build Tab (ビルド)
-- =====================================================
local BuildGroup = Tabs.Build:AddLeftGroupbox("🔧 おもしろ機能")
local l_Connection = nil
BuildGroup:AddToggle("LShown", {
    Text = "L表示",
    Default = false,
    Callback = function(Value)
        local player = Player
        local char = player.Character or player.CharacterAdded:Wait()
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        if not torso then return end
        local folderName = player.Name .. "SpawnedInToys"
        local folder = workspace:FindFirstChild(folderName)
        local toy = folder and folder:FindFirstChild("TetracubeJ")
        local main = toy and toy:FindFirstChild("Main")
        if not main then return end
        for _, v in ipairs(main.Parent:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false v.CanTouch = false end
        end
        local bp = main:FindFirstChild("L_BP") or Instance.new("BodyPosition")
        bp.Name = "L_BP"
        bp.Parent = main
        bp.P = 6000
        bp.D = 150
        local bg = main:FindFirstChild("L_BG") or Instance.new("BodyGyro")
        bg.Name = "L_BG"
        bg.Parent = main
        bg.P = 5000
        bg.D = 200
        if l_Connection then l_Connection:Disconnect() end
        if Value then
            bp.MaxForce = Vector3.new(1e6,1e6,1e6)
            bg.MaxTorque = Vector3.new(1e6,1e6,1e6)
            local t = 0
            l_Connection = RunService.RenderStepped:Connect(function(dt)
                if not main.Parent then if l_Connection then l_Connection:Disconnect() end return end
                t = t + dt
                local cf = torso.CFrame
                local offset = math.sin(t * 30) * 9
                bp.Position = torso.Position + cf.LookVector * (11 + offset)
                bg.CFrame = cf * CFrame.Angles(0, math.rad(180), 0)
            end)
        else
            bp.MaxForce = Vector3.zero
            bg.MaxTorque = Vector3.zero
        end
    end
})

-- =====================================================
-- LagKick Tab (ラグキック)
-- =====================================================
local LagKickGroup = Tabs.LagKick:AddLeftGroupbox("⏱️ ラグキック")
local LagKick = {Running=false}
local GrabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
local function startLineLag()
    if not GrabEvents then return end
    local createLine = GrabEvents:FindFirstChild("CreateGrabLine")
    if not createLine then return end
    task.spawn(function()
        while LagKick.Running do
            local spawnLocation = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawn") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
            if spawnLocation then
                local randomX = math.random(-1e9,1e9)
                local randomZ = math.random(-1e9,1e9)
local directions = {}
                local radius = 5
                local height = 20
                local points = 100
                for i = 1, points do
                    local angle = (i / points) * math.pi * 2
                    local x = math.cos(angle) * radius
                    local z = math.sin(angle) * radius
                    table.insert(directions, CFrame.new(x, height, z))
                end
                for _, pos in pairs(directions) do
                    pcall(function() createLine:FireServer(spawnLocation, pos) end)
                end
            end
            task.wait()
        end
    end)
end
LagKickGroup:AddButton({Text="🚀 サーバーラグ開始", Func=function()
    if LagKick.Running then return end
    LagKick.Running = true
    startLineLag()
    notify("ラグキック", "ラグ開始", 2)
end})
LagKickGroup:AddButton({Text="⏹ ラグ停止", Func=function()
    LagKick.Running = false
    notify("ラグキック", "ラグ停止", 2)
end})

-- =====================================================
-- Backpack Tab (おんぶ) - 全機能
-- =====================================================
local BackpackLeftGroup = Tabs.Backpack:AddLeftGroupbox("🎯 ターゲット選択")
local BackpackRightGroup = Tabs.Backpack:AddRightGroupbox("🎒 おんぶ")
local backpackActive = false
local backpackTask = nil
local backpackTargetName = ""
local BP_HEAD_POS = Vector3.new(0,1.5,0)
local BP_LARM_POS = Vector3.new(-1.5,0.5,-0.5)
local BP_RARM_POS = Vector3.new(1.5,0.5,-0.5)
local BP_LLEG_POS = Vector3.new(-1,-1.7,-0.7)
local BP_RLEG_POS = Vector3.new(1,-1.7,-0.7)
local BP_HEAD_ANG = Vector3.new(0,0,0)
local BP_LARM_ANG = Vector3.new(90,0,0)
local BP_RARM_ANG = Vector3.new(90,0,0)
local BP_LLEG_ANG = Vector3.new(80,45,-35)
local BP_RLEG_ANG = Vector3.new(80,-45,35)

local function GetBackpackPlayerList()
    local opts = {}
    for _, p in pairs(PS:GetPlayers()) do if p ~= LocalPlayer then table.insert(opts, p.DisplayName.." ("..p.Name..")") end end
    return opts
end
local function GetBackpackUserName(displayString)
    if not displayString or displayString == "" then return nil end
    local startPos = string.find(displayString, "%(")
    if startPos then return string.sub(displayString, startPos+1, -2) end
    return nil
end
local backpackDropdown = BackpackLeftGroup:AddDropdown("BackpackTargetSelect", {Text="プレイヤー選択", Default="", Values=GetBackpackPlayerList(), Callback=function(selected)
    local userName = GetBackpackUserName(selected)
    if userName then backpackTargetName = userName end
end})
local function UpdateBackpackList() backpackDropdown:SetValues(GetBackpackPlayerList()) end
PS.PlayerAdded:Connect(function() task.wait(0.5) UpdateBackpackList() end)
PS.PlayerRemoving:Connect(function() task.wait(0.2) UpdateBackpackList() end)
task.spawn(function() task.wait(1) UpdateBackpackList() end)

local backpackNoclipConnection = nil
local function BackpackEnableNoclip(targetChar)
    if backpackNoclipConnection then backpackNoclipConnection:Disconnect() end
    if not targetChar then return end
    for _, part in pairs(targetChar:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
    backpackNoclipConnection = targetChar.DescendantAdded:Connect(function(part) if part:IsA("BasePart") then part.CanCollide = false end end)
end
local function BackpackDisableNoclip(targetChar)
    if backpackNoclipConnection then backpackNoclipConnection:Disconnect() end
    if not targetChar then return end
    for _, part in pairs(targetChar:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = true end end
end
local function BackpackMainLoop()
    while backpackActive do
        local target = PS:FindFirstChild(backpackTargetName)
        if not target then task.wait(0.5) continue end
        local targetChar = target.Character
        if not targetChar then task.wait(0.1) continue end
        local tHRP = targetChar:FindFirstChild("HumanoidRootPart")
        local tHum = targetChar:FindFirstChild("Humanoid")
        if not tHRP or not tHum or tHum.Health <= 0 then task.wait(0.1) continue end
        BackpackEnableNoclip(targetChar)
        local myChar = LocalPlayer.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then task.wait(0.1) continue end
        while backpackActive do
            local target = PS:FindFirstChild(backpackTargetName)
            if not target then break end
            local tChar = target.Character
            if not tChar then break end
            local tHRP = tChar:FindFirstChild("HumanoidRootPart")
            local tHum = tChar:FindFirstChild("Humanoid")
            if not tHRP or not tHum then break end
            if tHum.Health <= 0 then break end
            BackpackEnableNoclip(tChar)
            local myChar = LocalPlayer.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myHRP then break end
            local baseCF = myHRP.CFrame * CFrame.new(0,1,1.5)
            tHRP.CFrame = baseCF
            tHRP.Velocity = Vector3.zero
            local head = tChar:FindFirstChild("Head")
            if head then head.CFrame = baseCF * CFrame.new(BP_HEAD_POS.X,BP_HEAD_POS.Y,BP_HEAD_POS.Z) * CFrame.Angles(math.rad(BP_HEAD_ANG.X),math.rad(BP_HEAD_ANG.Y),math.rad(BP_HEAD_ANG.Z)) end
            local leftArm = tChar:FindFirstChild("Left Arm")
            if leftArm then leftArm.CFrame = baseCF * CFrame.new(BP_LARM_POS.X,BP_LARM_POS.Y,BP_LARM_POS.Z) * CFrame.Angles(math.rad(BP_LARM_ANG.X),math.rad(BP_LARM_ANG.Y),math.rad(BP_LARM_ANG.Z)) end
            local rightArm = tChar:FindFirstChild("Right Arm")
            if rightArm then rightArm.CFrame = baseCF * CFrame.new(BP_RARM_POS.X,BP_RARM_POS.Y,BP_RARM_POS.Z) * CFrame.Angles(math.rad(BP_RARM_ANG.X),math.rad(BP_RARM_ANG.Y),math.rad(BP_RARM_ANG.Z)) end
            local leftLeg = tChar:FindFirstChild("Left Leg")
            if leftLeg then leftLeg.CFrame = baseCF * CFrame.new(BP_LLEG_POS.X,BP_LLEG_POS.Y,BP_LLEG_POS.Z) * CFrame.Angles(math.rad(BP_LLEG_ANG.X),math.rad(BP_LLEG_ANG.Y),math.rad(BP_LLEG_ANG.Z)) end
            local rightLeg = tChar:FindFirstChild("Right Leg")
            if rightLeg then rightLeg.CFrame = baseCF * CFrame.new(BP_RLEG_POS.X,BP_RLEG_POS.Y,BP_RLEG_POS.Z) * CFrame.Angles(math.rad(BP_RLEG_ANG.X),math.rad(BP_RLEG_ANG.Y),math.rad(BP_RLEG_ANG.Z)) end
            RunService.Heartbeat:Wait()
        end
        BackpackDisableNoclip(targetChar)
        task.wait(0.1)
    end
end
BackpackRightGroup:AddToggle("BackpackToggle", {Text="🎒 おんぶ", Default=false, Callback=function(Value)
    backpackActive = Value
    if Value then
        if backpackTargetName and backpackTargetName ~= "" then
            backpackTask = task.spawn(BackpackMainLoop)
            Library:Notify({Title="🎒 おんぶ", Description="開始: "..backpackTargetName, Duration=3})
        else
            backpackActive = false
            Toggles.BackpackToggle:SetValue(false)
            Library:Notify({Title="エラー", Description="先にターゲットを選択してください", Duration=3})
        end
    else
        if backpackTask then task.cancel(backpackTask) backpackTask = nil end
        local target = PS:FindFirstChild(backpackTargetName)
        if target and target.Character then BackpackDisableNoclip(target.Character) end
        Library:Notify({Title="🎒 おんぶ", Description="停止", Duration=2})
    end
end})

-- =====================================================
-- Plot Break (プロットブレイク)
-- =====================================================
local PlotBreak = {Enabled=false, SelectedPlots={}, SpawnedShurikens={}, Task=nil}
local PB_Remote = {SetNetworkOwner=nil, SpawnToyRemote=nil, DestroyToyRemote=nil, StickyPartEvent=nil}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        if v.Name == "SetNetworkOwner" then PB_Remote.SetNetworkOwner = v
        elseif v.Name == "DestroyToy" then PB_Remote.DestroyToyRemote = v end
    elseif v:IsA("RemoteFunction") and v.Name == "SpawnToyRemoteFunction" then PB_Remote.SpawnToyRemote = v end
end
pcall(function() PB_Remote.StickyPartEvent = ReplicatedStorage:WaitForChild("PlayerEvents"):WaitForChild("StickyPartEvent") end)

local function PB_cleanupShurikens()
    if PB_Remote.DestroyToyRemote then
        for _, shuriken in pairs(PlotBreak.SpawnedShurikens) do
            if shuriken and shuriken.Parent then pcall(function() PB_Remote.DestroyToyRemote:FireServer(shuriken) end) end
        end
    end
    PlotBreak.SpawnedShurikens = {}
end
local function PB_getHRP()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return LocalPlayer.Character.HumanoidRootPart
    else local character = LocalPlayer.CharacterAdded:Wait() return character:WaitForChild("HumanoidRootPart") end
end
local function PB_CheckForHome()
    if not Workspace.PlotItems.PlayersInPlots:FindFirstChild(LocalPlayer.Name) then return false end
    for _, v in pairs(Workspace.Plots:GetChildren()) do
        if v:FindFirstChild("PlotSign") then
            local sign = v.PlotSign
            local owners = sign:FindFirstChild("ThisPlotsOwners")
            if owners then
                for _, b in pairs(owners:GetChildren()) do
                    if b.Value == LocalPlayer.Name then
                        local folder = Workspace.PlotItems:FindFirstChild(v.Name)
                        if folder then return true, folder end
                    end
                end
            end
        end
    end
    return false
end
local function PB_startLoop()
    PB_cleanupShurikens()
    local plr = LocalPlayer
    if not plr then return end
    local canSpawnObj = plr:FindFirstChild("CanSpawnToy")
    if not canSpawnObj then return end
    while PlotBreak.Enabled do
        local validPlots = {}
        for _, plotName in pairs(PlotBreak.SelectedPlots) do
            local targetPlot = Workspace.Plots:FindFirstChild(plotName)
            local plotArea = targetPlot and targetPlot:FindFirstChild("PlotArea")
            if plotArea then table.insert(validPlots, {Name=plotName, Area=plotArea}) end
        end
        local requiredCount = #validPlots
        if requiredCount == 0 then task.wait(1) continue end
        local boolik, house = PB_CheckForHome()
        local inv = Workspace:FindFirstChild(plr.Name.."SpawnedInToys")
        local targetContainer = (boolik and house) or inv
        local activeOwnShurikens = {}
        for _, s in pairs(PlotBreak.SpawnedShurikens) do if s and s.Parent then table.insert(activeOwnShurikens, s) end end
        PlotBreak.SpawnedShurikens = activeOwnShurikens
        local currentOwnCount = #PlotBreak.SpawnedShurikens
        if currentOwnCount < requiredCount then
            local neededSpawns = requiredCount - currentOwnCount
            for i = 1, neededSpawns do
                if not PlotBreak.Enabled then break end
                local preExisting = {}
                if targetContainer then
                    for _, child in pairs(targetContainer:GetChildren()) do
                        if child.Name == "NinjaShuriken" then table.insert(preExisting, child) end
                    end
                end
                local t = tick()
                while not canSpawnObj.Value do
                    if not PlotBreak.Enabled then break end
                    if tick() - t > 3 then break end
                    task.wait(0.01)
                end
                if not PlotBreak.Enabled then break end
                local currentHRP = PB_getHRP()
                if currentHRP and PB_Remote.SpawnToyRemote then
                    task.spawn(function()
                        pcall(function() PB_Remote.SpawnToyRemote:InvokeServer("NinjaShuriken", currentHRP.CFrame * CFrame.new(0,2,8), Vector3.zero) end)
                    end)
                end
                local newShuriken = nil
                if targetContainer then
                    local searchStart = tick()
                    while tick() - searchStart < 2 do
                        for _, child in pairs(targetContainer:GetChildren()) do
                            if child.Name == "NinjaShuriken" and not table.find(preExisting, child) and not table.find(PlotBreak.SpawnedShurikens, child) then
                                newShuriken = child
                                break
                            end
                        end
                        if newShuriken then
                            if PB_Remote.SetNetworkOwner then
                                local soundPart = newShuriken:FindFirstChild("SoundPart")
                                if soundPart then
                                    task.spawn(function() pcall(function() PB_Remote.SetNetworkOwner:FireServer(soundPart, soundPart.CFrame) end) end)
                                end
                            end
                            break
                        end
                        task.wait()
                    end
                end
                if newShuriken then
                    table.insert(PlotBreak.SpawnedShurikens, newShuriken)
                    local targetPlotData = validPlots[#PlotBreak.SpawnedShurikens]
                    if targetPlotData and newShuriken:FindFirstChild("StickyPart") and PB_Remote.StickyPartEvent then
                        pcall(function()
                            PB_Remote.StickyPartEvent:FireServer(newShuriken.StickyPart, targetPlotData.Area, CFrame.new(999999999600,999999999600,999999999600,1,0,0,0,1,0,0,0,1))
                        end)
                    end
                end
                task.wait(0.05)
            end
        end
        if not PlotBreak.Enabled then PB_cleanupShurikens() break end
        task.wait(0.5)
    end
end

local PlotBreakTab = Tabs.PlotBreak
local PlotSelectGroup = PlotBreakTab:AddLeftGroupbox("🏠 プロット選択")
local plotDropdown = PlotSelectGroup:AddDropdown("PlotBreakSelect", {Values={"Plot1","Plot2","Plot3","Plot4","Plot5"}, Default={}, Multi=true, Text="プロット選択", Callback=function(Options)
    PlotBreak.SelectedPlots = {}
    for _, plot in pairs(Options) do table.insert(PlotBreak.SelectedPlots, plot) end
end})
local PlotControlGroup = PlotBreakTab:AddRightGroupbox("🎮 コントロール")
local plotBreakToggle = PlotControlGroup:AddToggle("PlotBreakToggle", {Text="🏠 プロット破壊", Default=false, Callback=function(Value)
    PlotBreak.Enabled = Value
    if PlotBreak.Enabled then
        if #PlotBreak.SelectedPlots == 0 then
            notify("エラー", "少なくとも1つのプロットを選択してください", 3)
            PlotBreak.Enabled = false
            if plotBreakToggle and plotBreakToggle.SetValue then plotBreakToggle:SetValue(false) end
            return
        end
        notify("プロット破壊", "起動しました", 3)
        if PlotBreak.Task then task.cancel(PlotBreak.Task) PlotBreak.Task = nil end
        PlotBreak.Task = task.spawn(PB_startLoop)
    else
        if PlotBreak.Task then task.cancel(PlotBreak.Task) PlotBreak.Task = nil end
        PB_cleanupShurikens()
        notify("プロット破壊", "停止しました", 3)
    end
end})
PlotControlGroup:AddButton({Text="🧹 手裏剣クリーンアップ", Func=function() PB_cleanupShurikens() notify("クリーンアップ", "全ての手裏剣を削除しました", 3) end})

-- =====================================================
-- UI Settings
-- =====================================================
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("⚙️ メニュー設定")
MenuGroup:AddButton("アンロード", function() Library:Unload() end)
MenuGroup:AddLabel("メニューキーバインド"):AddKeyPicker("MenuKeybind", {Default="RightShift", NoUI=true, Text="メニューキー"})
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
ThemeManager:SetFolder("MashumeroHub")
SaveManager:SetFolder("MashumeroHub/Configs")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

Library:Notify({Title="👾 ましゅめろ", Description="全機能読み込み完了！", Time=3})
]]

    local success, err = pcall(loadstring(lemonScript))
    if success then
        print("✅ ましゅめろ（旧れもにーHUB）全機能起動成功！")
    else
        warn("❌ ましゅめろ起動失敗: " .. tostring(err))
    end
end)

-- ==========================================
-- キックタブ（ましゅめろキック本体 - 両手対応版）
-- ==========================================
local KickTab = Window:MakeTab({Name = "キック", Icon = "rbxassetid://4483362458", PremiumOnly = false})

-- ==========================================
-- 共通変数
-- ==========================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- ブロブマン管理
-- ==========================================
local spawnedBlobman = nil
local isSpawning = false
local alreadyKicked = {}

local function spawnBlobman()
    if isSpawning then return end
    isSpawning = true
    
    local char = LocalPlayer.Character
    if not char then isSpawning = false return nil end
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart then isSpawning = false return nil end
    
    local spawnPos = rootPart.CFrame * CFrame.new(0, 0, -8)
    pcall(function()
        ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer("CreatureBlobman", spawnPos, Vector3.new(0, 127, 0))
    end)
    
    local toyFolderName = LocalPlayer.Name .. "SpawnedInToys"
    local blobman = nil
    local startTime = tick()
    repeat
        local toyFolder = Workspace:FindFirstChild(toyFolderName)
        if toyFolder then
            blobman = toyFolder:FindFirstChild("CreatureBlobman")
            if blobman then break end
        end
        task.wait(0.1)
    until tick() - startTime > 3
    
    isSpawning = false
    if blobman then
        spawnedBlobman = blobman
        local seat = blobman:FindFirstChild("VehicleSeat")
        if seat then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then seat:Sit(humanoid) end
        end
        return blobman
    end
    return nil
end

local function destroyBlobman()
    if spawnedBlobman and spawnedBlobman.Parent then
        local destroyrem = ReplicatedStorage:FindFirstChild("MenuToys") and ReplicatedStorage.MenuToys:FindFirstChild("DestroyToy")
        if destroyrem then pcall(function() destroyrem:FireServer(spawnedBlobman) end) else spawnedBlobman:Destroy() end
        spawnedBlobman = nil
    end
end

local function getBlobmanSeat()
    if spawnedBlobman and spawnedBlobman.Parent then
        return spawnedBlobman:FindFirstChild("VehicleSeat")
    end
    return nil
end

-- ==========================================
-- プレイヤー選択
-- ==========================================
local selectedKickPlayer = nil
local targetName = ""
local kickPlayerDropdown = nil

local function getPlayerList()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(list, plr.DisplayName .. " (" .. plr.Name .. ")")
        end
    end
    if #list == 0 then table.insert(list, "プレイヤーがいません")
    end
    return list
end

local function getPlayerFromSelection(selection)
    if not selection or selection == "" then return nil end
    if selection == "プレイヤーがいません" then return nil end
    local username = selection:match("%((.-)%)")
    if username then return Players:FindFirstChild(username) end
    return nil
end

local function forceUpdatePlayerList()
    local newOptions = getPlayerList()
    if kickPlayerDropdown then
        kickPlayerDropdown:Refresh(newOptions, true)
    end
end

kickPlayerDropdown = KickTab:AddDropdown({
    Name = "ターゲット",
    Default = "",
    Options = getPlayerList(),
    Callback = function(Value)
        selectedKickPlayer = getPlayerFromSelection(Value)
        if selectedKickPlayer then
            targetName = selectedKickPlayer.Name
            alreadyKicked[targetName] = false
        end
    end
})

KickTab:AddButton({
    Name = "更新",
    Callback = function()
        forceUpdatePlayerList()
    end
})

Players.PlayerAdded:Connect(function()
    task.wait(0.3)
    forceUpdatePlayerList()
end)

Players.PlayerRemoving:Connect(function()
    task.wait(0.2)
    forceUpdatePlayerList()
end)

-- ==========================================
-- ドリフトキック（両手対応版：R_Det + L_Det）
-- ==========================================
local orbitRadius = 15
local orbitSpeed2 = 2
local orbitAngle = 0
local driftKickEnabled = false
local driftKickThread = nil
local alreadyKilled = {}

KickTab:AddSlider({
    Name = "半径",
    Min = 5, Max = 30, Default = 15, Increment = 1, ValueName = "m",
    Callback = function(Value) orbitRadius = Value end
})

KickTab:AddSlider({
    Name = "速度",
    Min = 1, Max = 10, Default = 2, Increment = 1, ValueName = "",
    Callback = function(Value) orbitSpeed2 = Value end
})

KickTab:AddToggle({
    Name = "ドリフトキック（両手）",
    Default = false,
    Callback = function(on)
        if driftKickThread then task.cancel(driftKickThread) driftKickThread = nil end
        driftKickEnabled = on
        
        if on then
            if not spawnedBlobman or not spawnedBlobman.Parent then
                spawnBlobman()
                task.wait(0.5)
            end
        else
            destroyBlobman()
            orbitAngle = 0
            return
        end
        
        if on and not selectedKickPlayer then
            OrionLib:MakeNotification({Name = "エラー", Content = "ターゲットを選択してください", Time = 2})
            driftKickEnabled = false
            return
        end
        
        local seat = getBlobmanSeat()
        if on and not seat then
            spawnBlobman()
            task.wait(0.5)
            seat = getBlobmanSeat()
            if not seat then
                driftKickEnabled = false
                return
            end
        end
        
        if not on then orbitAngle = 0 return end
        
        local target = selectedKickPlayer
        targetName = target.Name
        alreadyKicked[targetName] = false
        alreadyKilled[targetName] = false
        
        driftKickThread = task.spawn(function()
            local GE = ReplicatedStorage:WaitForChild("GrabEvents")
            local blob = spawnedBlobman
            if not blob or not blob.Parent then driftKickEnabled = false return end
            
            local blobRoot = blob:FindFirstChild("HumanoidRootPart") or blob.PrimaryPart
            if not blobRoot then driftKickEnabled = false return end
            
            local scriptObj = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
            local CG = scriptObj and scriptObj:FindFirstChild("CreatureGrab")
            local CD = scriptObj and scriptObj:FindFirstChild("CreatureDrop")
            
            -- ★★★ 両手Detectorを取得 ★★★
            local R_Det = blob:FindFirstChild("RightDetector")
            local R_Weld = R_Det and (R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld"))
            
            local L_Det = blob:FindFirstChild("LeftDetector")
            local L_Weld = L_Det and (L_Det:FindFirstChild("LeftWeld") or L_Det:FindFirstChildWhichIsA("Weld"))
            
            local SavedPos = blobRoot.CFrame
            
            local tChar = target.Character
            local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
            
            -- 初期引き寄せ（両手で掴む）
            if tRoot and blobRoot then
                local bringStart = tick()
                while tick() - bringStart < 0.15 and driftKickEnabled do
                    blobRoot.CFrame = tRoot.CFrame
                    blobRoot.Velocity = Vector3.zero
                    pcall(function()
                        -- 右手で掴む
                        if CG and R_Det then CG:FireServer(R_Det, tRoot, R_Weld) end
                        -- 左手で掴む
                        if CG and L_Det then CG:FireServer(L_Det, tRoot, L_Weld) end
                        GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        GE.SetNetworkOwner:FireServer(tRoot, blobRoot.CFrame)
                    end)
                    RunService.Heartbeat:Wait()
                end
                blobRoot.CFrame = SavedPos
                blobRoot.Velocity = Vector3.zero
                task.wait(0.05)
            end

            local packetTimer = 0
            local handSwitch = 0  -- 0:右手, 1:左手, 2:両手
            
            while driftKickEnabled do
                local currentTarget = Players:FindFirstChild(targetName)
                if not currentTarget then
                    if not alreadyKicked[targetName] then
                        alreadyKicked[targetName] = true
                        OrionLib:MakeNotification({
                            Name = "🎯 キック完了！",
                            Content = targetName .. " をキックしました！",
                            Time = 3
                        })
                    end
                    break
                end
                

                

                
tChar = currentTarget.Character
tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
local tHum = tChar and tChar:FindFirstChild("Humanoid")

if not tChar or not tRoot or not tHum then
    task.wait(0.1)
    continue
end

if tHum and tHum.Health <= 0 then
    if not alreadyKilled[targetName] then
        alreadyKilled[targetName] = true
        OrionLib:MakeNotification({
            Name = "💀 ターゲットが死亡しました",
            Content = "",
            Time = 2
        })
    end

end
                
                if tRoot and tHum and tHum.Health > 0 then
                    local lockPos = SavedPos * CFrame.new(0, 18, 0)
                    tRoot.CFrame = lockPos
                    tRoot.Velocity = Vector3.zero
                    tRoot.RotVelocity = Vector3.zero
                    tRoot.AssemblyLinearVelocity = Vector3.zero
                    tRoot.AssemblyAngularVelocity = Vector3.zero
                    -- ★ アンチキック対策 ★
                    local targetPlayer = Players:FindFirstChild(targetName)
                    if targetPlayer then
                        local spawned = workspace:FindFirstChild(targetPlayer.Name .. "SpawnedInToys")
                        if spawned then
                            for _, toyName in ipairs({"NinjaKunai", "NinjaShuriken", "AntiKick"}) do
                                local toy = spawned:FindFirstChild(toyName)
                                if toy then
                                    local soundPart = toy:FindFirstChild("SoundPart")
                                    if soundPart then
                                        pcall(function()
                                            GE.SetNetworkOwner:FireServer(soundPart, soundPart.CFrame)
                                        end)
                                        if soundPart:FindFirstChild("PartOwner") and soundPart.PartOwner.Value == LocalPlayer.Name then
                                            soundPart.CFrame = CFrame.new(0, 1000, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    local dt = RunService.Heartbeat:Wait()
                    orbitAngle = orbitAngle + (dt * orbitSpeed2)
                    local orbitX = math.cos(orbitAngle) * orbitRadius
                    local orbitZ = math.sin(orbitAngle) * orbitRadius
                    local orbitCFrame = lockPos * CFrame.new(orbitX, 0, orbitZ)
                    local lookAtCFrame = CFrame.lookAt(orbitCFrame.Position, lockPos.Position)
                    blobRoot.CFrame = lookAtCFrame
                    blobRoot.Velocity = Vector3.zero
                    tRoot.CFrame = lockPos
                    task.wait()
                    tRoot.CFrame = lockPos
                    task.wait()
                    tRoot.CFrame = lockPos
                    if tick() - packetTimer > 0.01 then  -- ★★★ 爆速！ 0.00005 ★★★
                        packetTimer = tick()
                      
                        -- ★★★ 両手交互掴み ★★★
                        handSwitch = (handSwitch + 1) % 3
                        
                        pcall(function()
                            tHum.PlatformStand = true
                            tHum.Sit = true
                            GE.SetNetworkOwner:FireServer(tRoot, lockPos)
                            
                            if handSwitch == 0 then
                                -- 右手で掴む
                                if R_Det then
                                    local weld = R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld")
                                    if weld then CD:FireServer(weld) end
                                    CG:FireServer(R_Det, tRoot, R_Weld)
                                end
                            elseif handSwitch == 1 then
                                -- 左手で掴む
                                if L_Det then
                                    local weld = L_Det:FindFirstChild("LeftWeld") or L_Det:FindFirstChildWhichIsA("Weld")
                                    if weld then CD:FireServer(weld) end
                                    CG:FireServer(L_Det, tRoot, L_Weld)
                                end
                            else
                                -- 両手で同時に掴む
                                if R_Det then
                                    local weld = R_Det:FindFirstChild("RightWeld") or R_Det:FindFirstChildWhichIsA("Weld")
                                    if weld then CD:FireServer(weld) end
                                    CG:FireServer(R_Det, tRoot, R_Weld)
                                end
                                if L_Det then
                                    local weld = L_Det:FindFirstChild("LeftWeld") or L_Det:FindFirstChildWhichIsA("Weld")
                                    if weld then CD:FireServer(weld) end
                                    CG:FireServer(L_Det, tRoot, L_Weld)
                                end
                            end
                            
                            GE.DestroyGrabLine:FireServer(tRoot)
                            GE.CreateGrabLine:FireServer(tRoot, Vector3.zero, tRoot.Position, false)
                        end)
                    end
                else
                    if blobRoot and blobRoot.Parent then
                        blobRoot.CFrame = SavedPos
                        blobRoot.Velocity = Vector3.zero
                    end
                end
                RunService.Heartbeat:Wait()
            end
            orbitAngle = 0
            if blobRoot and blobRoot.Parent then
                blobRoot.CFrame = SavedPos
                blobRoot.Velocity = Vector3.zero
            end
        end)
    end
})

-- ==========================================
-- ラグタブ
-- ==========================================
local LagTab = Window:MakeTab({
    Name = "ラグ",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local lineLagThread = nil
local lineLagEnabled = false
local GrabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")

local function startLineLag()
    if lineLagEnabled then return end
    lineLagEnabled = true
    lineLagThread = task.spawn(function()
        if not GrabEvents then return end
        local createLine = GrabEvents:FindFirstChild("CreateGrabLine")
        if not createLine then return end

        while lineLagEnabled do
            local target = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawn") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
            if target then
                for i = 1, 10 do 
                    local randomX = math.random(-1e9, 1e9)
                    local randomZ = math.random(-1e9, 1e9)
                    pcall(function() 
                        createLine:FireServer(target, CFrame.new(randomX, 0, randomZ)) 
                    end)
                end
            end
            task.wait(0.05) 
        end
    end)
end

local function stopLineLag()
    lineLagEnabled = false
    if lineLagThread then task.cancel(lineLagThread) end
end

local LagToggle = LagTab:AddToggle({
    Name = "ラグ発生",
    Default = false,
    Callback = function(Value)
        if Value then
            startLineLag()
            OrionLib:MakeNotification({Name = "ラグ", Content = "開始しました", Time = 1})
        else
            stopLineLag()
            OrionLib:MakeNotification({Name = "ラグ", Content = "停止しました", Time = 1})
        end
    end
})

LagTab:AddButton({
    Name = "ラグ解除",
    Callback = function()
        stopLineLag()
        LagToggle:Set(false)
        OrionLib:MakeNotification({Name = "ラグ", Content = "完全に停止しました", Time = 1})
    end
})

-- ==========================================
-- トリガータブ
-- ==========================================
local TriggerTab = Window:MakeTab({
    Name = "トリガー",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
-- ==========================================
-- グラブキック タブ
-- ==========================================
local GrabKickTab = Window:MakeTab({
    Name = "グラブキック",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local _GK_Players = game:GetService("Players")
local _GK_RS = game:GetService("ReplicatedStorage")
local _GK_RunService = game:GetService("RunService")
local _GK_Workspace = game:GetService("Workspace")
local _GK_LocalPlayer = _GK_Players.LocalPlayer
local _GK_GrabEvents = _GK_RS:WaitForChild("GrabEvents")
local _GK_SpawnToy = _GK_RS:WaitForChild("MenuToys"):WaitForChild("SpawnToyRemoteFunction")
local _GK_SetNetworkOwner = _GK_GrabEvents:WaitForChild("SetNetworkOwner")
local _GK_CreateLine = _GK_GrabEvents:FindFirstChild("CreateGrabLine")

local _GK_Enabled = false
local _GK_TargetName = ""
local _GK_LagRunning = false

local function _GK_GetPlayerList()
    local list = {}
    for _, plr in ipairs(_GK_Players:GetPlayers()) do
        if plr ~= _GK_LocalPlayer then
            table.insert(list, plr.DisplayName .. " (@" .. plr.Name .. ")")
        end
    end
    return list
end

local function _GK_GetPlayer(display)
    for _, plr in ipairs(_GK_Players:GetPlayers()) do
        if (plr.DisplayName .. " (@" .. plr.Name .. ")") == display then
            return plr
        end
    end
    return nil
end

local function _GK_TeleportToPlayer(target, myHrp)
    if not target.Character then return end
    local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not tHrp or not myHrp then return end
    local saved = myHrp.CFrame
    myHrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 2)
    for i = 1, 15 do
        _GK_SetNetworkOwner:FireServer(tHrp, tHrp.CFrame)
        task.wait()
    end
    myHrp.CFrame = saved
end

local function _GK_StartLag()
    if _GK_LagRunning then return end
    if not _GK_CreateLine then return end
    _GK_LagRunning = true
    task.spawn(function()
        while _GK_LagRunning do
            local spawn = _GK_Workspace:FindFirstChild("SpawnLocation")
                or _GK_Workspace:FindFirstChild("Spawn")
                or (_GK_LocalPlayer.Character and _GK_LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
            if spawn then
                for i = 1, 50 do
                    _GK_CreateLine:FireServer(spawn, CFrame.new(math.random(-2e9, 2e9), 0, math.random(-2e9, 2e9)))
                end
            end
            task.wait()
        end
    end)
end

local function _GK_StopLag()
    _GK_LagRunning = false
end

local _GK_Dropdown = GrabKickTab:AddDropdown({
    Name = "ターゲット選択",
    Default = "",
    Options = _GK_GetPlayerList(),
    Callback = function(Value)
        _GK_TargetName = Value
    end
})

GrabKickTab:AddButton({
    Name = "🔄 リスト更新",
    Callback = function()
        _GK_Dropdown:Refresh(_GK_GetPlayerList())
    end
})

GrabKickTab:AddToggle({
    Name = "Grab Kick (BETA)",
    Default = false,
    Callback = function(Value)
        _GK_Enabled = Value
        
        if Value then
            _GK_StartLag()
        else
            _GK_StopLag()
        end
        
        if _GK_Enabled then
            task.spawn(function()
                while _GK_Enabled do
                    local target = _GK_GetPlayer(_GK_TargetName)
                    local myChar = _GK_LocalPlayer.Character
                    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    
                    if target and myHrp then
                        local tChar = target.Character
                        local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
                        
                        if tHrp then
                            local dist = (myHrp.Position - tHrp.Position).Magnitude
                            if dist > 25 then
                                _GK_TeleportToPlayer(target, myHrp)
                            end
                            
                            _GK_SetNetworkOwner:FireServer(tHrp, tHrp.CFrame)
                            if _GK_GrabEvents:FindFirstChild("DestroyGrabLine") then
                                _GK_GrabEvents.DestroyGrabLine:FireServer(tHrp)
                            end
                            
                            tHrp.AssemblyLinearVelocity = Vector3.zero
                            tHrp.AssemblyAngularVelocity = Vector3.zero
                            
                            local bp = tHrp:FindFirstChild("ControlBP")
                            if not bp then
                                bp = Instance.new("BodyPosition")
                                bp.Name = "ControlBP"
                                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                bp.P = 800000
                                bp.Parent = tHrp
                            end
                            bp.Position = myHrp.Position + Vector3.new(5, 10, 5)
                        end
                    end
                    task.wait()
                end
                
                local target = _GK_GetPlayer(_GK_TargetName)
                if target and target.Character then
                    local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if tHrp and tHrp:FindFirstChild("ControlBP") then
                        tHrp.ControlBP:Destroy()
                    end
                end
            end)
        end
    end
})

_GK_Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    _GK_Dropdown:Refresh(_GK_GetPlayerList())
end)
_GK_Players.PlayerRemoving:Connect(function()
    task.wait(0.3)
    _GK_Dropdown:Refresh(_GK_GetPlayerList())
end)
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

local isMobile = UserInputService.TouchEnabled

local fpsEnabled = false
local fpsLabel = nil
local lastTimestamp = tick()
local frameCount = 0

local function createFPSLabel()
    if fpsLabel then return end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FPSCounter"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0, 80, 0, 30)
    fpsLabel.Position = UDim2.new(1, -90, 0, 10)
    fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    fpsLabel.BackgroundTransparency = 0.3
    fpsLabel.BorderSizePixel = 0
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.TextSize = 14
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.Text = "FPS: 0"
    fpsLabel.Parent = screenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = fpsLabel
end

local function destroyFPSLabel()
    if fpsLabel then
        local parent = fpsLabel.Parent
        if parent then parent:Destroy() end
        fpsLabel = nil
    end
end

local function updateFPS()
    while fpsEnabled and fpsLabel do
        frameCount = frameCount + 1
        local now = tick()
        if now - lastTimestamp >= 1 then
            local fps = frameCount
            fpsLabel.Text = "FPS: " .. fps
            frameCount = 0
            lastTimestamp = now
        end
        RunService.Heartbeat:Wait()
    end
end

local function startFPS()
    if fpsEnabled then
        destroyFPSLabel()
        createFPSLabel()
        task.spawn(updateFPS)
    else
        destroyFPSLabel()
    end
end

local espEnabled = false
local espObjects = {}
local espConnections = {}

local function createESP(player)
    if not espEnabled then return nil end
    if espObjects[player] then return espObjects[player] end
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local nameGui = Instance.new("BillboardGui")
    nameGui.Size = UDim2.new(0, 120, 0, 25)
    nameGui.StudsOffset = Vector3.new(0, 2.5, 0)
    nameGui.AlwaysOnTop = true
    nameGui.Parent = hrp
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.Text = player.Name
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = nameGui
    local dotGui = Instance.new("BillboardGui")
    dotGui.Size = UDim2.new(0, 8, 0, 8)
    dotGui.StudsOffset = Vector3.new(0, 0, 0)
    dotGui.AlwaysOnTop = true
    dotGui.Parent = hrp
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(1, 0, 1, 0)
    dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    dot.BorderSizePixel = 0
    dot.Parent = dotGui
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    local charConnection = nil
    charConnection = char.AncestryChanged:Connect(function()
        if not char.Parent then
            if nameGui then nameGui:Destroy() end
            if dotGui then dotGui:Destroy() end
            espObjects[player] = nil
            if charConnection then charConnection:Disconnect() end
        end
    end)
    espObjects[player] = {
        nameGui = nameGui,
        dotGui = dotGui,
        charConnection = charConnection
    }
    return espObjects[player]
end

local function removeESP(player)
    local data = espObjects[player]
    if data then
        if data.nameGui then data.nameGui:Destroy() end
        if data.dotGui then data.dotGui:Destroy() end
        if data.charConnection then data.charConnection:Disconnect() end
        espObjects[player] = nil
    end
end

local function clearAllESP()
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    espObjects = {}
end

local function updateESP()
    if not espEnabled then
        clearAllESP()
        return
    end
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= LocalPlayer then
            createESP(otherPlayer)
        end
    end
end

local function startESP()
    if espEnabled then
        updateESP()
        local playerAddedConn = Players.PlayerAdded:Connect(function(otherPlayer)
            if espEnabled and otherPlayer ~= LocalPlayer then
                createESP(otherPlayer)
            end
        end)
        table.insert(espConnections, playerAddedConn)
        local playerRemovedConn = Players.PlayerRemoving:Connect(function(otherPlayer)
            removeESP(otherPlayer)
        end)
        table.insert(espConnections, playerRemovedConn)
        local updateConn = RunService.RenderStepped:Connect(function()
            if espEnabled then
                for _, otherPlayer in ipairs(Players:GetPlayers()) do
                    if otherPlayer ~= LocalPlayer then
                        if not espObjects[otherPlayer] then
                            createESP(otherPlayer)
                        end
                    end
                end
            end
        end)
        table.insert(espConnections, updateConn)
    else
        clearAllESP()
        for _, conn in ipairs(espConnections) do
            conn:Disconnect()
        end
        espConnections = {}
    end
end

local fovEnabled = false
local originalFOV = nil
local currentFOV = 100

local function saveOriginalFOV()
    if originalFOV == nil then
        originalFOV = Camera.FieldOfView
        currentFOV = originalFOV
    end
end

local function setFOV(value)
    currentFOV = math.clamp(value, 1, 120)
    if fovEnabled then
        Camera.FieldOfView = currentFOV
    end
end

local function setFOVEnabled(state)
    saveOriginalFOV()
    fovEnabled = state
    if fovEnabled then
        Camera.FieldOfView = currentFOV
    else
        Camera.FieldOfView = originalFOV
    end
end

local triggerEnabled = false
local triggerRange = 150
local triggerConnection = nil
local lastGrabTime = 0
local grabCooldown = 0.1
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local vu = VirtualUser

local function getTarget()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    if Workspace:FindFirstChild("GrabParts") then return nil end
    local origin = Camera.CFrame.Position
    local dir = Camera.CFrame.LookVector
    rayParams.FilterDescendantsInstances = {char, Workspace.Terrain}
    local result = Workspace:Raycast(origin, dir * triggerRange, rayParams)
    if not result then return nil end
    local model = result.Instance:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    if model == char then return nil end
    if humanoid.Health <= 0 then return nil end
    return model
end

local function doGrab()
    local now = tick()
    if now - lastGrabTime < grabCooldown then return end
    lastGrabTime = now
    task.spawn(function()
        local viewport = Camera.ViewportSize
        local center = Vector2.new(viewport.X / 2, viewport.Y / 2)
        pcall(function()
            vu:CaptureController()
            vu:Button1Down(center)
            task.wait(0.02)
            vu:Button1Up(center)
        end)
    end)
end

local function onTriggerLoop()
    if not triggerEnabled then return end
    local target = getTarget()
    if target then
        doGrab()
    end
end

local function setTriggerEnabled(state)
    triggerEnabled = state
    if triggerEnabled then
        if triggerConnection then triggerConnection:Disconnect() end
        triggerConnection = RunService.Heartbeat:Connect(onTriggerLoop)
    else
        if triggerConnection then
            triggerConnection:Disconnect()
            triggerConnection = nil
        end
    end
end

local aimbotEnabled = false
local aimbotSmoothness = 3
local aimbotFOV = 300
local aimbotPart = "Head"
local aimbotConnection = nil
local aimbotActive = false
local aimbotAutoLock = true
local currentTarget = nil

local aimbotButton = nil
local aimbotButtonGui = nil

local function createMobileAimbotButton()
    if not isMobile then return end
    if aimbotButton then return end
    
    aimbotButtonGui = Instance.new("ScreenGui")
    aimbotButtonGui.Name = "AimbotButton"
    aimbotButtonGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    aimbotButtonGui.ResetOnSpawn = false
    
    aimbotButton = Instance.new("TextButton")
    aimbotButton.Size = UDim2.new(0, 70, 0, 70)
    aimbotButton.Position = UDim2.new(1, -85, 0.5, -35)
    aimbotButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    aimbotButton.BorderSizePixel = 0
    aimbotButton.Text = "AIM"
    aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimbotButton.TextSize = 16
    aimbotButton.Font = Enum.Font.GothamBold
    aimbotButton.Parent = aimbotButtonGui
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = aimbotButton
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(100, 100, 120)
    buttonStroke.Thickness = 2
    buttonStroke.Parent = aimbotButton
    
    aimbotButton.TouchTap:Connect(function()
        aimbotActive = true
        task.wait()
        aimbotActive = false
    end)
    
    local longPressConnection = nil
    aimbotButton.TouchLongPress:Connect(function()
        aimbotActive = true
        longPressConnection = RunService.Heartbeat:Connect(function()
            aimbotActive = true
        end)
    end)
    
    aimbotButton.TouchEnded:Connect(function()
        aimbotActive = false
        if longPressConnection then
            longPressConnection:Disconnect()
            longPressConnection = nil
        end
    end)
end

local function destroyMobileAimbotButton()
    if aimbotButtonGui then
        aimbotButtonGui:Destroy()
        aimbotButton = nil
        aimbotButtonGui = nil
    end
end

local function getClosestPlayerToCenter()
    local closestPlayer = nil
    local shortestDistance = aimbotFOV
    local viewportSize = Camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= LocalPlayer then
            local character = otherPlayer.Character
            if character then
                local targetPart = character:FindFirstChild(aimbotPart)
                if not targetPart then
                    targetPart = character:FindFirstChild("HumanoidRootPart")
                end
                if targetPart then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestPlayer = otherPlayer
                        end
                    end
                end
            end
        end
    end
    return closestPlayer, shortestDistance
end

local function smoothLookAt(targetPosition)
    local newCFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPosition), 0.3)
    Camera.CFrame = newCFrame
end

local function onAimbotLoop()
    if not aimbotEnabled then return end
    
    local shouldAim = false
    if aimbotAutoLock then
        shouldAim = true
    elseif isMobile then
        shouldAim = aimbotActive
    else
        shouldAim = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
    end
    
    if not shouldAim then
        currentTarget = nil
        return
    end
    
    local targetPlayer, distance = getClosestPlayerToCenter()
    if targetPlayer and distance <= aimbotFOV then
        currentTarget = targetPlayer
        local character = targetPlayer.Character
        if character then
            local targetPart = character:FindFirstChild(aimbotPart)
            if not targetPart then
                targetPart = character:FindFirstChild("HumanoidRootPart")
            end
            if targetPart then
                smoothLookAt(targetPart.Position)
            end
        end
    else
        currentTarget = nil
    end
end

local function setAimbotEnabled(state)
    aimbotEnabled = state
    if aimbotEnabled then
        if aimbotConnection then aimbotConnection:Disconnect() end
        aimbotConnection = RunService.RenderStepped:Connect(onAimbotLoop)
        if isMobile then
            createMobileAimbotButton()
        end
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        aimbotActive = false
        currentTarget = nil
        if isMobile then
            destroyMobileAimbotButton()
        end
    end
end

-- Trigger Tab GUI
TriggerTab:AddSection({ Name = "Trigger Bot" })
TriggerTab:AddToggle({
    Name = "Trigger Bot",
    Default = false,
    Callback = function(Value) setTriggerEnabled(Value) end
})
TriggerTab:AddSlider({
    Name = "Grab Range",
    Min = 50, Max = 500, Default = 150, Increment = 10,
    ValueName = "studs",
    Callback = function(Value) triggerRange = Value end
})

TriggerTab:AddSection({ Name = "ESP" })
TriggerTab:AddToggle({
    Name = "ESP (Name + Position)",
    Default = false,
    Callback = function(Value) espEnabled = Value; startESP() end
})

TriggerTab:AddSection({ Name = "Aimbot (自動吸い付き)" })
TriggerTab:AddToggle({
    Name = "Aimbot (常時自動ロック)",
    Default = false,
    Callback = function(Value) setAimbotEnabled(Value) end
})
if not isMobile then
    TriggerTab:AddLabel("PC: 自動吸い付きモード (ONで常に敵に照準)")
else
    TriggerTab:AddLabel("スマホ: 自動吸い付きモード (ONで常に敵に照準)")
end
TriggerTab:AddSlider({
    Name = "Aimbot FOV (検出範囲)",
    Min = 50, Max = 500, Default = 300, Increment = 10,
    ValueName = "pixels",
    Callback = function(Value) aimbotFOV = Value end
})
TriggerTab:AddSlider({
    Name = "吸い付き強さ (Smoothness)",
    Min = 1, Max = 20, Default = 3, Increment = 1,
    ValueName = "smooth",
    Callback = function(Value) aimbotSmoothness = Value end
})
TriggerTab:AddDropdown({
    Name = "Aimbot Target Part",
    Default = "Head",
    Options = {"Head", "HumanoidRootPart", "Torso"},
    Callback = function(Value) aimbotPart = Value end
})

TriggerTab:AddSection({ Name = "FOV (Field of View)" })
TriggerTab:AddToggle({
    Name = "FOV Modifier",
    Default = false,
    Callback = function(Value) setFOVEnabled(Value) end
})
TriggerTab:AddSlider({
    Name = "FOV Value",
    Min = 1, Max = 120, Default = 100, Increment = 1,
    ValueName = "degrees",
    Callback = function(Value) setFOV(Value) end
})

TriggerTab:AddSection({ Name = "FPS Counter" })
TriggerTab:AddToggle({
    Name = "Show FPS Counter",
    Default = false,
    Callback = function(Value) fpsEnabled = Value; startFPS() end
})

-- ==========================================
-- 初期化
-- ==========================================
OrionLib:Init()

OrionLib:MakeNotification({
    Name = "起動完了！",
    Content = "ましゅめろキック（両手対応）\n👾 ましゅめろ（旧れもにーHUB）全機能同時起動",
    Time = 3
})local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
Library.ForceCheckbox = false

local Window = Library:CreateWindow({
    Title = "Dragonic",
    Footer = "Made by Siroo",
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Ragdoll = Window:AddTab("Ragdoll", "hammer"),
}

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder("Dragonic")
SaveManager:SetFolder("Dragonic/Configs")
SaveManager:SetSubFolder("config")

do
    local RagdollGroup = Tabs.Ragdoll:AddLeftGroupbox("Ragdoll Kill")
    
    local selectedPlayer = nil
    local isLooping = false
    local loopConnection = nil
    local monitorConnection = nil
    local currentBanana = nil
    local playerDropdown = nil
    local isTargetDead = false
    local toggleRef = nil
    
    -- Ragdoll Kill用
    local isRagdollActive = false
    local ragdollMonitorTask = nil
    
    local function getLocalChar()
        return LocalPlayer.Character
    end
    
    local function getHumanoidRootPart()
        local char = getLocalChar()
        if char then
            return char:FindFirstChild("HumanoidRootPart")
        end
        return nil
    end
    
    local function getSpawnedToysFolder()
        return Workspace:FindFirstChild(LocalPlayer.Name .. "SpawnedInToys")
    end
    
    -- ============================================================
    -- Ragdoll Kill 関数
    -- ============================================================
    local function destroyAllPencils()
        local folder = getSpawnedToysFolder()
        if not folder then return end
        local destroyToy = ReplicatedStorage:FindFirstChild("MenuToys") and ReplicatedStorage.MenuToys:FindFirstChild("DestroyToy")
        if not destroyToy then return end
        for _, child in pairs(folder:GetChildren()) do
            if child.Name == "ToolPencil" then
                pcall(function()
                    destroyToy:FireServer(child)
                end)
            end
        end
    end
    
    local function countPencils()
        local folder = getSpawnedToysFolder()
        if not folder then return 0 end
        local count = 0
        for _, child in pairs(folder:GetChildren()) do
            if child.Name == "ToolPencil" then
                count = count + 1
            end
        end
        return count
    end
    
    local function isPencilWeldedToTarget()
        local folder = getSpawnedToysFolder()
        if not folder then return false end
        
        local target = Players:FindFirstChild(selectedPlayer)
        if not target or not target.Character then return false end
        local targetHead = target.Character:FindFirstChild("Head")
        if not targetHead then return false end
        
        for _, child in pairs(folder:GetChildren()) do
            if child.Name == "ToolPencil" then
                local stickyPart = child:FindFirstChild("StickyPart")
                if stickyPart then
                    local weld = stickyPart:FindFirstChild("StickyWeld")
                    if weld and weld.Part1 == targetHead then
                        return true
                    end
                end
            end
        end
        return false
    end
    
    local function spawnToolPencil()
        local hrp = getHumanoidRootPart()
        if not hrp then return nil end
        
        local spawnPos = hrp.CFrame * CFrame.new(0, 14, 20)
        local menuToys = ReplicatedStorage:FindFirstChild("MenuToys")
        if not menuToys then return nil end
        
        local spawnRemote = menuToys:FindFirstChild("SpawnToyRemoteFunction")
        if not spawnRemote then return nil end
        
        local spawned = nil
        local folder = getSpawnedToysFolder()
        if not folder then return nil end
        
        local conn
        conn = folder.ChildAdded:Connect(function(child)
            if child.Name == "ToolPencil" then
                spawned = child
                conn:Disconnect()
            end
        end)
        
        task.spawn(function()
            pcall(function()
                spawnRemote:InvokeServer("ToolPencil", spawnPos, Vector3.zero)
            end)
        end)
        
        local start = tick()
        repeat
            task.wait(0.05)
        until spawned or (tick() - start) > 3
        
        if conn then
            pcall(function() conn:Disconnect() end)
        end
        
        return spawned
    end
    
    local function setNetworkOwnerPencil(part)
        if not part then return end
        local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
        if not grabEvents then return end
        local setNet = grabEvents:FindFirstChild("SetNetworkOwner")
        if not setNet then return end
        
        pcall(function()
            setNet:FireServer(part, part.CFrame)
            setNet:FireServer(part, part.CFrame)
            setNet:FireServer(part, part.CFrame)
            setNet:FireServer(part, part.CFrame)
            setNet:FireServer(part, part.CFrame)
        end)
    end
    
    local function doSticky()
        if not selectedPlayer or selectedPlayer == "" then return false end
        
        local target = Players:FindFirstChild(selectedPlayer)
        if not target or not target.Character then return false end
        
        local targetHead = target.Character:FindFirstChild("Head")
        if not targetHead then return false end
        
        destroyAllPencils()
        task.wait(0.05)
        
        local pencil = spawnToolPencil()
        if not pencil then return false end
        
        local soundPart = pencil:FindFirstChild("SoundPart")
        local stickyPart = pencil:FindFirstChild("StickyPart")
        
        if soundPart then
            setNetworkOwnerPencil(soundPart)
        end
        
        task.wait(0.05)
        
        if stickyPart then
            local stickyEvent = ReplicatedStorage:FindFirstChild("PlayerEvents") and ReplicatedStorage.PlayerEvents:FindFirstChild("StickyPartEvent")
            if stickyEvent then
                pcall(function()
                    stickyEvent:FireServer(stickyPart, targetHead, CFrame.new(0, 0/0, 0))
                    stickyEvent:FireServer(stickyPart, targetHead, CFrame.new(0, 0/0, 0))
                end)
                
                task.wait(0.5)
                
                if not isPencilWeldedToTarget() then
                    destroyAllPencils()
                    task.wait(0.05)
                    doSticky()
                end
                
                return true
            end
        end
        return false
    end
    
    local function RagdollRespawnMonitor()
        local target = Players:FindFirstChild(selectedPlayer)
        if not target then return end
        
        target.CharacterAdded:Connect(function()
            if isRagdollActive then
                doSticky()
            end
        end)
    end
    
    local function PencilMonitor()
        while isRagdollActive do
            local count = countPencils()
            
            if count == 0 then
                doSticky()
            elseif count >= 2 then
                destroyAllPencils()
                task.wait(0.05)
                doSticky()
            elseif count == 1 then
                if not isPencilWeldedToTarget() then
                    destroyAllPencils()
                    task.wait(0.05)
                    doSticky()
                end
            end
            
            task.wait(0.1)
        end
    end
    
    -- ============================================================
    -- Loop Banana Ragdoll
    -- ============================================================
    local function setNetworkOwner(part)
        if not part then return end
        local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
        if not grabEvents then return end
        local setNet = grabEvents:FindFirstChild("SetNetworkOwner")
        if not setNet then return end
        
        pcall(function()
            setNet:FireServer(part, part.CFrame)
        end)
    end
    
    local function destroyGrabLine(part)
        if not part then return end
        local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
        if not grabEvents then return end
        local destroyLine = grabEvents:FindFirstChild("DestroyGrabLine")
        if not destroyLine then return end
        
        pcall(function()
            destroyLine:FireServer(part)
        end)
    end
    
    local function destroyBanana(banana)
        if not banana then return end
        local menuToys = ReplicatedStorage:FindFirstChild("MenuToys")
        if not menuToys then return end
        local destroyToy = menuToys:FindFirstChild("DestroyToy")
        if not destroyToy then return end
        
        pcall(function()
            destroyToy:FireServer(banana)
        end)
    end
    
    local function spawnBanana()
        local hrp = getHumanoidRootPart()
        if not hrp then return nil end
        
        local spawnPos = hrp.CFrame * CFrame.new(0, 14, 20)
        local menuToys = ReplicatedStorage:FindFirstChild("MenuToys")
        if not menuToys then return nil end
        
        local spawnRemote = menuToys:FindFirstChild("SpawnToyRemoteFunction")
        if not spawnRemote then return nil end
        
        local spawned = nil
        local folder = getSpawnedToysFolder()
        if not folder then return nil end
        
        local conn
        conn = folder.ChildAdded:Connect(function(child)
            if child.Name == "FoodBanana" then
                spawned = child
                conn:Disconnect()
            end
        end)
        
        task.spawn(function()
            pcall(function()
                spawnRemote:InvokeServer("FoodBanana", spawnPos, Vector3.zero)
            end)
        end)
        
        local start = tick()
        repeat
            task.wait(0.05)
        until spawned or (tick() - start) > 3
        
        if conn then
            pcall(function() conn:Disconnect() end)
        end
        
        return spawned
    end
    
    local function holdBanana(banana)
        if not banana then return end
        local holdPart = banana:FindFirstChild("HoldPart")
        if not holdPart then return end
        
        local holdRemote = holdPart:FindFirstChild("HoldItemRemoteFunction")
        if not holdRemote then return end
        
        local char = getLocalChar()
        if not char then return end
        
        local success = false
        for i = 1, 5 do
            if not banana or not banana.Parent then break end
            local result = pcall(function()
                return holdRemote:InvokeServer(banana, char)
            end)
            if result then
                success = true
                break
            end
            task.wait(0.05)
        end
        return success
    end
    
    local function useBanana(banana)
        if not banana then return end
        local useEvent = ReplicatedStorage:FindFirstChild("HoldEvents") and ReplicatedStorage.HoldEvents:FindFirstChild("Use")
        if not useEvent then return end
        
        pcall(function()
            useEvent:FireServer(banana)
        end)
    end
    
    local function dropBanana(banana)
        if not banana then return end
        local holdPart = banana:FindFirstChild("HoldPart")
        if not holdPart then return end
        local dropRemote = holdPart:FindFirstChild("DropItemRemoteFunction")
        if not dropRemote then return end
        local hrp = getHumanoidRootPart()
        if not hrp then return end
        
        local dropPos = hrp.CFrame * CFrame.new(0, 15, 0)
        pcall(function()
            dropRemote:InvokeServer(banana, dropPos, dropPos)
        end)
    end
    
    local function getTargetLeg()
        if not selectedPlayer then return nil end
        local target = Players:FindFirstChild(selectedPlayer)
        if not target or not target.Character then return nil end
        return target.Character:FindFirstChild("Left Leg")
    end
    
    local function getTargetHealth()
        if not selectedPlayer then return 0 end
        local target = Players:FindFirstChild(selectedPlayer)
        if not target or not target.Character then return 0 end
        local hum = target.Character:FindFirstChildOfClass("Humanoid")
        if not hum then return 0 end
        return hum.Health
    end
    
    local function fullBananaCycle()
        if not selectedPlayer or selectedPlayer == "" then return false end
        
        local banana = spawnBanana()
        if not banana then return false end
        
        holdBanana(banana)
        task.wait(0.05)
        holdBanana(banana)
        task.wait(0.05)
        
        task.wait(0.5)
        
        useBanana(banana)
        
        task.wait(2.3)
        
        dropBanana(banana)
        task.wait(0.05)
        dropBanana(banana)
        
        task.wait(0.3)
        
        return banana
    end
    
    -- ループ再開用の関数
    local function restartLoop(banana)
        if loopConnection then
            loopConnection:Disconnect()
            loopConnection = nil
        end
        
        currentBanana = banana
        
        local hitboxPart = banana:FindFirstChild("HitboxPart")
        if not hitboxPart then return end
        
        loopConnection = RunService.Heartbeat:Connect(function()
            if not isLooping then
                stopLoop()
                return end
            
            if not currentBanana or not currentBanana.Parent then
                return end
            
            local folder = getSpawnedToysFolder()
            local bananaExists = false
            if folder then
                for _, child in pairs(folder:GetChildren()) do
                    if child.Name == "FoodBanana" then
                        bananaExists = true
                        currentBanana = child
                        hitboxPart = child:FindFirstChild("HitboxPart")
                        break
                    end
                end
            end
            
            if not bananaExists or not hitboxPart then
                loopConnection:Disconnect()
                loopConnection = nil
                currentBanana = nil
                if isLooping then
                    task.wait(0.05)
                    -- 監視ループが再スポーンしてくれる
                end
                return
            end
            
            local hrp = getHumanoidRootPart()
            if not hrp then return end
            
            local targetPos
            local targetCFrame
            
            local health = getTargetHealth()
            if health <= 0 then
                isTargetDead = true
                targetPos = hrp.CFrame * CFrame.new(0, 7, 0)
                targetCFrame = CFrame.new(targetPos.Position)
            else
                isTargetDead = false
                local leg = getTargetLeg()
                if leg then
                    targetPos = leg.CFrame * CFrame.new(0, 0.5, 0)
                    targetCFrame = leg.CFrame
                else
                    targetPos = hrp.CFrame * CFrame.new(0, 7, 0)
                    targetCFrame = CFrame.new(targetPos.Position)
                end
            end
            
            setNetworkOwner(hitboxPart)
            destroyGrabLine(hitboxPart)
            
            local bp = hitboxPart:FindFirstChild("BodyPosition")
            if bp then
                bp.Position = targetPos.Position
            else
                bp = Instance.new("BodyPosition")
                bp.P = 10000
                bp.D = 100
                bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bp.Position = targetPos.Position
                bp.Parent = hitboxPart
            end
            
            local bg = hitboxPart:FindFirstChild("BodyGyro")
            if bg then
                bg.CFrame = targetCFrame
            else
                bg = Instance.new("BodyGyro")
                bg.P = 10000
                bg.D = 100
                bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                bg.CFrame = targetCFrame
                bg.Parent = hitboxPart
            end
        end)
    end
    
    local function startLoop()
        if isLooping then return end
        if not selectedPlayer or selectedPlayer == "" then return end
        
        isLooping = true
        isTargetDead = false
        
        local banana = fullBananaCycle()
        if banana then
            restartLoop(banana)
        end
        
        -- バナナ監視用ループ
        monitorConnection = RunService.Heartbeat:Connect(function()
            if not isLooping then return end
            
            local folder = getSpawnedToysFolder()
            local bananaExists = false
            if folder then
                for _, child in pairs(folder:GetChildren()) do
                    if child.Name == "FoodBanana" then
                        bananaExists = true
                        break
                    end
                end
            end
            
            if not bananaExists then
                -- ループ停止
                if loopConnection then
                    loopConnection:Disconnect()
                    loopConnection = nil
                end
                
                task.wait(0.05)
                
                -- 新しいバナナをスポーン
                local newBanana = fullBananaCycle()
                if newBanana then
                    -- ループ再開
                    restartLoop(newBanana)
                end
            end
        end)
    end
    
    local function stopLoop()
        isLooping = false
        if loopConnection then
            loopConnection:Disconnect()
            loopConnection = nil
        end
        if monitorConnection then
            monitorConnection:Disconnect()
            monitorConnection = nil
        end
        
        if currentBanana then
            destroyBanana(currentBanana)
            local hitboxPart = currentBanana:FindFirstChild("HitboxPart")
            if hitboxPart then
                local bp = hitboxPart:FindFirstChild("BodyPosition")
                if bp then bp:Destroy() end
                local bg = hitboxPart:FindFirstChild("BodyGyro")
                if bg then bg:Destroy() end
            end
            currentBanana = nil
        end
        
        local folder = getSpawnedToysFolder()
        if folder then
            for _, child in pairs(folder:GetChildren()) do
                if child.Name == "FoodBanana" then
                    destroyBanana(child)
                end
            end
        end
    end
    
    -- ============================================================
    -- UI
    -- ============================================================
    local function GetPlayerList()
        local list = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(list, player.DisplayName .. " (" .. player.Name .. ")")
            end
        end
        return list
    end
    
    local function GetPlayerNameFromDisplay(display)
        if not display or display == "" then return nil end
        local startPos, endPos = string.find(display, "%(")
        if startPos then
            return string.sub(display, startPos + 1, -2)
        end
        return nil
    end
    
    playerDropdown = RagdollGroup:AddDropdown("TargetSelect", {
        Text = "Select Player",
        Default = "",
        Values = GetPlayerList(),
        Callback = function(v)
            local name = GetPlayerNameFromDisplay(v)
            if name then
                selectedPlayer = name
            else
                selectedPlayer = nil
            end
        end
    })
    
    local function UpdatePlayerList()
        if playerDropdown then
            playerDropdown:SetValues(GetPlayerList())
        end
    end
    
    Players.PlayerAdded:Connect(function()
        task.wait(0.5)
        UpdatePlayerList()
    end)
    
    Players.PlayerRemoving:Connect(function()
        task.wait(0.2)
        UpdatePlayerList()
    end)
    
    task.spawn(function()
        task.wait(1)
        UpdatePlayerList()
    end)
    
    -- Ragdoll Kill Toggle
    RagdollGroup:AddToggle("RagdollKill", {
        Text = "Ragdoll Kill",
        Default = false,
        Callback = function(v)
            if v then
                if not selectedPlayer or selectedPlayer == "" then
                    return
                end
                isRagdollActive = true
                doSticky()
                RagdollRespawnMonitor()
                ragdollMonitorTask = task.spawn(PencilMonitor)
            else
                isRagdollActive = false
                if ragdollMonitorTask then
                    task.cancel(ragdollMonitorTask)
                    ragdollMonitorTask = nil
                end
                destroyAllPencils()
            end
        end
    })
    -- =====================================================
-- LagKick Control (Ragdollタブに追加)
-- =====================================================
local LagKick = {
    Enabled = false,
    SelectedHeight = "Spawn",
    Running = false,
}

local _LagPlayers = game:GetService("Players")
local _LagLocalPlayer = _LagPlayers.LocalPlayer
local _LagRS = game:GetService("ReplicatedStorage")
local _LagWorkspace = game:GetService("Workspace")
local _LagGrabEvents = _LagRS:FindFirstChild("GrabEvents")

_G.LineLagPacketCount = 10
local lineLagThread = nil
local lineLagEnabled = false

local function getAllPlayers()
    local players = {}
    for _, plr in pairs(_LagPlayers:GetPlayers()) do
        if plr ~= _LagLocalPlayer then
            table.insert(players, plr)
        end
    end
    return players
end

local function spamOwnership(hrp)
    if not _LagGrabEvents then return end
    local setOwner = _LagGrabEvents:FindFirstChild("SetNetworkOwner")
    if setOwner and hrp then
        pcall(function() setOwner:FireServer(hrp, hrp.CFrame) end)
    end
end

local function teleportToPlayer(myHrp, targetHrp)
    if not myHrp or not targetHrp then return end
    pcall(function()
        myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 5, 5)
        myHrp.AssemblyLinearVelocity = Vector3.zero
    end)
end

local function destroyLineOnPlayer(hrp)
    if not _LagGrabEvents then return end
    local createLine = _LagGrabEvents:FindFirstChild("CreateGrabLine")
    local destroyLine = _LagGrabEvents:FindFirstChild("DestroyGrabLine")
    if not createLine or not destroyLine then return end
    pcall(function()
        createLine:FireServer(hrp, CFrame.new(0, 1e9, 0))
        task.wait()
        destroyLine:FireServer(hrp)
    end)
end

local function startLineLag()
    if lineLagEnabled then return end
    lineLagEnabled = true
    lineLagThread = task.spawn(function()
        if not _LagGrabEvents then return end
        local createLine = _LagGrabEvents:FindFirstChild("CreateGrabLine")
        if not createLine then
            Library:Notify({ Title = "Error", Description = "CreateGrabLine not found", Time = 3 })
            return
        end
        local packetCount = _G.LineLagPacketCount or 10
        while lineLagEnabled do
            local target = _LagWorkspace:FindFirstChild("SpawnLocation") 
                or _LagWorkspace:FindFirstChild("Spawn") 
                or (_LagLocalPlayer.Character and _LagLocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
            if target then
                for i = 1, packetCount do 
                    local randomX = math.random(-1e9, 1e9)
                    local randomZ = math.random(-1e9, 1e9)
                    pcall(function() 
                        createLine:FireServer(target, CFrame.new(randomX, 0, randomZ)) 
                    end)
                end
            end
            task.wait(0.05) 
        end
    end)
end

local function stopLineLag()
    lineLagEnabled = false
    if lineLagThread then 
        task.cancel(lineLagThread) 
        lineLagThread = nil
    end
end

-- =====================================================
-- UI追加
-- =====================================================
local LagKickGroup = Tabs.Ragdoll:AddLeftGroupbox("LagKick Control")

LagKickGroup:AddDropdown("HeightMode", {
    Values = { "Spawn (Ground)", "Heaven" },
    Default = 1,
    Text = "Height Mode",
    Callback = function(Value)
        LagKick.SelectedHeight = (Value == "Heaven") and "Heaven" or "Spawn"
    end,
})

LagKickGroup:AddButton({
    Text = "🚀 Destroy Server",
    Tooltip = "全てのプレイヤーを円形に配置し、サーバーにラグを発生させます",
    Func = function()
        if LagKick.Running then
            Library:Notify({ Title = "Already Running", Description = "Destroy Server is already in progress", Time = 3 })
            return
        end
        LagKick.Running = true
        Library:Notify({ Title = "⚠️", Description = "Destroy Server Started!", Time = 2 })
        task.spawn(function()
            local height = (LagKick.SelectedHeight == "Heaven") and 1e9 or 35
            startLineLag()
            task.wait(1)
            local players = getAllPlayers()
            if #players == 0 then
                stopLineLag()
                LagKick.Running = false
                Library:Notify({ Title = "Error", Description = "No players found", Time = 3 })
                return
            end
            Library:Notify({ Title = "Target", Description = #players .. " players found", Time = 2 })
            local myChar = _LagLocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myHrp then
                stopLineLag()
                LagKick.Running = false
                return
            end
            local playerData = {}
            for _, plr in ipairs(players) do
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    table.insert(playerData, { player = plr, hrp = hrp })
                end
            end
            for _, data in ipairs(playerData) do
                teleportToPlayer(myHrp, data.hrp)
                task.wait(0.2)
                spamOwnership(data.hrp)
                task.wait()
            end
            local radius = 5
            local angleStep = (math.pi * 2) / #playerData
            for idx, data in ipairs(playerData) do
                local angle = (idx - 1) * angleStep
                local x = math.cos(angle) * radius
                local z = math.sin(angle) * radius
                pcall(function()
                    data.hrp.CFrame = CFrame.new(x, height, z)
                    data.hrp.AssemblyLinearVelocity = Vector3.zero
                end)
                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bp.P = 40000000
                bp.Position = Vector3.new(x, height, z)
                bp.Parent = data.hrp
                task.delay(2, function() pcall(function() bp:Destroy() end) end)
                task.wait()
            end
            for i = 1, 8 do
                for _, data in ipairs(playerData) do
                    destroyLineOnPlayer(data.hrp)
                end
                task.wait(0.3)
            end
            LagKick.Running = false
            Library:Notify({ Title = "✔ Complete", Description = "Destruction complete!", Time = 3 })
        end)
    end,
})

LagKickGroup:AddButton({
    Text = "⏹ Stop Lag",
    Tooltip = "ラインラグを停止します",
    Func = function()
        stopLineLag()
        LagKick.Running = false
        Library:Notify({ Title = "Stopped", Description = "Lag stopped", Time = 2 })
    end,
})

LagKickGroup:AddDivider()
LagKickGroup:AddLabel("Status: Idle")

local LagOptionGroup = Tabs.Ragdoll:AddRightGroupbox("LagKick オプション")

LagOptionGroup:AddSlider("PacketCount", {
    Text = "1回あたりのパケット数",
    Default = 10,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Suffix = "件",
    Tooltip = "1ループで送信するライン作成リクエストの数",
    Callback = function(Value)
        _G.LineLagPacketCount = Value
    end,
})
    -- Loop Banana Ragdoll Toggle
    toggleRef = RagdollGroup:AddToggle("LoopBananaRagdoll", {
        Text = "Loop Banana Ragdoll",
        Default = false,
        Callback = function(v)
            if v then
                if not selectedPlayer or selectedPlayer == "" then
                    toggleRef:Set(false)
                    return
                end
                stopLoop()
                startLoop()
            else
                stopLoop()
            end
        end
    })
end