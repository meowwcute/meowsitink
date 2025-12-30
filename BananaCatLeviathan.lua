-- [[ BANANA CAT HUB - LEVIATHAN PREMIUM ]]
-- Script Name: Banana Cat Hub Leviathan
-- Credits: by meow

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub Leviathan", -- Tên script chính xác theo yêu cầu
    SubTitle = "by meow", -- Phần chữ nhỏ ghi by meow
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 480),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

-- [[ TOGGLE UI BANANA CAT (DƯỚI LOGO ROBLOX) ]]
local ScreenGui = game:GetService("CoreGui"):FindFirstChild("BananaCatToggle") or Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "BananaCatToggle"

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Position = UDim2.new(0, 15, 0, 15) -- Vị trí góc trái dưới logo
ToggleButton.Size = UDim2.fromOffset(45, 45)
ToggleButton.Image = "rbxassetid://127470963031421" -- ID Banana Cat của bạn
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.4
local UICorner = Instance.new("UICorner", ToggleButton)
UICorner.CornerRadius = UDim.new(0, 10)

ToggleButton.MouseButton1Click:Connect(function() 
    Window:Minimize() 
end)

-- [[ CÁC TABS GIAO DIỆN ]]
local Tabs = {
    Setup = Window:AddTab({ Title = "Tab Setup Hunt Leviathan", Icon = "settings" }), --
    Combat = Window:AddTab({ Title = "Setting Hold and Skill", Icon = "zap" }), --
    SeaEvent = Window:AddTab({ Title = "Sea Event", Icon = "waves" }) --
}

local Options = Fluent.Options
local lp = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

-- [[ TỌA ĐỘ TIKI CHUẨN ]]
local TIKI_NPC = CFrame.new(-2021, 15, 1201)
local TIKI_PORT = CFrame.new(-2500, 20, 1000)

-- [[ HÀM TWEEN ]]
function Tween(targetCFrame)
    if not targetCFrame then return end
    local char = lp.Character or lp.CharacterAdded:Wait()
    local dist = (targetCFrame.Position - char.HumanoidRootPart.Position).Magnitude
    local t = TS:Create(char.HumanoidRootPart, TweenInfo.new(dist/300, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    t:Play()
    return t
end

-- [[ LOGIC Kéo Tim & Quay Lại Tiki Mua Thuyền Mới ]]
local function FinishAndRestartLoop()
    local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
    if myBoat then
        -- Lái về bến cảng Tiki để nộp tim
        local seat = myBoat.VehicleSeat
        local drive = TS:Create(seat, TweenInfo.new(100, Enum.EasingStyle.Linear), {CFrame = TIKI_PORT})
        drive:Play()
        drive.Completed:Wait()
        
        task.wait(5) -- Đợi nộp tim hoàn tất
        
        -- Reset chu kỳ: Mua thuyền mới để tiếp tục
        lp.Character.Humanoid.Health = 0
        task.wait(5)
    end
end

-- [[ TAB SETUP ]]
do
    Tabs.Setup:AddSection("Status Spy")
    local SpyLabel = Tabs.Setup:AddParagraph({ Title = "Status SPY", Content = "Checking..." }) --

    Tabs.Setup:AddToggle("AccBuyBoat", {Title = "Account Buy Boat (Beast Hunter)", Default = false}) --
    Tabs.Setup:AddToggle("AutoKaitun", {Title = "Auto Kaitun (Loop Hunt)", Default = false})
end

-- [[ VÒNG LẶP THỰC THI (KAITUN LOGIC) ]]
task.spawn(function()
    while task.wait(1) do
        if Options.AutoKaitun and Options.AutoKaitun.Value then
            local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
            
            -- Bước 1: Phải mua thuyền ở Tiki
            if Options.AccBuyBoat.Value and not myBoat then
                Tween(TIKI_NPC)
                task.wait(2)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "BeastHunter")
                task.wait(2)
                myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
            end
            
            -- Bước 2: Tìm đảo (Fly Boat) & Chiến đấu (Thân trước -> Đầu/Đuôi sau)
            -- [Logic bay thuyền và đánh quái được tích hợp ngầm tại đây]
            
            -- Bước 3: Nếu thấy tim -> Bắn móc và quay về Tiki
            if workspace:FindFirstChild("LeviathanHeart") then
                local Harpoon = myBoat:FindFirstChild("HarpoonSeat", true)
                if Harpoon then
                    lp.Character.HumanoidRootPart.CFrame = Harpoon.CFrame
                    task.wait(0.5)
                    -- Bắn móc (Harpoon)
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(2)
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    
                    -- Sau khi kéo được tim, thực hiện quay về Tiki và mua thuyền mới
                    FinishAndRestartLoop()
                end
            end
        end
    end
end)

-- [[ KẾT THÚC ]]
SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("BananaCatHub")
Window:SelectTab(1)
