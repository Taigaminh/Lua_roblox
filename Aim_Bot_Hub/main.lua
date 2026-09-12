local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Bảng màu Modern Dark Theme
local THEME = {
    Background = Color3.fromRGB(18, 18, 24),
    Container = Color3.fromRGB(28, 28, 36),
    Button = Color3.fromRGB(38, 38, 50),
    Accent = Color3.fromRGB(0, 210, 255),
    Text = Color3.fromRGB(240, 240, 245),
    TextSub = Color3.fromRGB(160, 160, 175),
    ToggleOn = Color3.fromRGB(80, 220, 120),
    ToggleOff = Color3.fromRGB(255, 85, 85),
    CloseBtn = Color3.fromRGB(235, 60, 80)
}

-- Hàm hỗ trợ tạo UICorner nhanh
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

-- Tạo ScreenGUI
local MenuGUI = Instance.new("ScreenGui")
MenuGUI.Name = "MenuGUI"
MenuGUI.DisplayOrder = 10
MenuGUI.IgnoreGuiInset = true
MenuGUI.ResetOnSpawn = false
MenuGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Icon Mở Menu
local frameIcon = Instance.new("Frame")
frameIcon.Name = "frameIcon"
frameIcon.Size = UDim2.new(0, 35, 0, 35)
frameIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
frameIcon.BackgroundColor3 = THEME.Container
frameIcon.BorderSizePixel = 0
frameIcon.Parent = MenuGUI
addCorner(frameIcon, 10)

local Icon = Instance.new("ImageButton")
Icon.Name = "Icon"
Icon.Size = UDim2.new(1, 0, 1, 0)
Icon.BackgroundColor3 = THEME.Accent
Icon.BackgroundTransparency = 0.8
Icon.BorderSizePixel = 0
Icon.Parent = frameIcon
addCorner(Icon, 10)

-- Khung Main Menu
local frame = Instance.new("Frame")
frame.Name = "frame"
frame.Size = UDim2.new(0, 520, 0, 340)
frame.Position = UDim2.new(0.15, 0, 0.15, 0)
frame.BackgroundColor3 = THEME.Background
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = MenuGUI
addCorner(frame, 10)

-- Thanh Tiêu Đề (Title Bar)
local Title = Instance.new("TextButton")
Title.Name = "Title"
Title.Text = "  nhỏ nhạc Hub  |  make by: Next :>"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = THEME.Accent
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = THEME.Container
Title.BorderSizePixel = 0
Title.AutoButtonColor = false
Title.Parent = frame

-- Nút Đóng (Close)
local closeButton = Instance.new("TextButton")
closeButton.Name = "closeButton"
closeButton.Text = "x"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = THEME.Text
closeButton.Size = UDim2.new(0, 35, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = THEME.CloseBtn
closeButton.BorderSizePixel = 0
closeButton.Parent = Title
addCorner(closeButton, 8)

-- Thanh Cuộn Danh Mục Bên Trái (Left Navigation)
local MenuScrolling = Instance.new("ScrollingFrame")
MenuScrolling.Name = "MenuScrolling"
MenuScrolling.Size = UDim2.new(0, 130, 1, -45)
MenuScrolling.Position = UDim2.new(0, 8, 0, 40)
MenuScrolling.BackgroundColor3 = THEME.Container
MenuScrolling.BorderSizePixel = 0
MenuScrolling.ScrollBarThickness = 2
MenuScrolling.ScrollBarImageColor3 = THEME.Accent
MenuScrolling.Parent = frame
addCorner(MenuScrolling, 8)

local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Padding = UDim.new(0, 4)
LeftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
LeftListLayout.Parent = MenuScrolling

local LeftPadding = Instance.new("UIPadding")
LeftPadding.PaddingTop = UDim.new(0, 4)
LeftPadding.PaddingBottom = UDim.new(0, 4)
LeftPadding.PaddingLeft = UDim.new(0, 4)
LeftPadding.PaddingRight = UDim.new(0, 4)
LeftPadding.Parent = MenuScrolling

-- Template Nút Bấm
local textButton = Instance.new("TextButton")
textButton.Name = "Button"
textButton.Font = Enum.Font.GothamMedium
textButton.TextSize = 13
textButton.TextColor3 = THEME.Text
textButton.Size = UDim2.new(1, 0, 0, 32)
textButton.BackgroundColor3 = THEME.Button
textButton.BorderSizePixel = 0
addCorner(textButton, 6)

-- Template Khung Nội Dung Bên Phải (Right Content Frame)
local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Name = "Scrolling"
Scrolling.Size = UDim2.new(1, -154, 1, -45)
Scrolling.Position = UDim2.new(0, 146, 0, 40)
Scrolling.BackgroundColor3 = THEME.Container
Scrolling.BorderSizePixel = 0
Scrolling.ScrollBarThickness = 3
Scrolling.ScrollBarImageColor3 = THEME.Accent
Scrolling.Visible = false
Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
addCorner(Scrolling, 8)

local RightListLayout = Instance.new("UIListLayout")
RightListLayout.Padding = UDim.new(0, 6)
RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
RightListLayout.Parent = Scrolling

local RightPadding = Instance.new("UIPadding")
RightPadding.PaddingTop = UDim.new(0, 6)
RightPadding.PaddingBottom = UDim.new(0, 6)
RightPadding.PaddingLeft = UDim.new(0, 6)
RightPadding.PaddingRight = UDim.new(0, 6)
RightPadding.Parent = Scrolling

RightListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, RightListLayout.AbsoluteContentSize.Y + 12)
end)

-- Template TextBox
local textTextBox = Instance.new("TextBox")
textTextBox.Name = "TextBox"
textTextBox.Font = Enum.Font.Gotham
textTextBox.TextSize = 13
textTextBox.TextColor3 = THEME.Text
textTextBox.Size = UDim2.new(1, 0, 0, 32)
textTextBox.BackgroundColor3 = THEME.Button
textTextBox.BorderSizePixel = 0
textTextBox.PlaceholderColor3 = THEME.TextSub
textTextBox.ClearTextOnFocus = false
addCorner(textTextBox, 6)

-- Template Dropdown Frame
local frameTop = Instance.new("Frame")
frameTop.Name = "frameTop"
frameTop.Size = UDim2.new(1, 0, 0, 32)
frameTop.BackgroundColor3 = THEME.Button
frameTop.BorderSizePixel = 0
addCorner(frameTop, 6)

-- Notification UI
local FrameNotification = Instance.new("Frame")
FrameNotification.Name = "FrameNotification"
FrameNotification.Size = UDim2.new(0, 220, 0, 60)
FrameNotification.Position = UDim2.new(1, 10, 0, 20)
FrameNotification.BackgroundColor3 = THEME.Container
FrameNotification.BorderSizePixel = 0
FrameNotification.Visible = false
addCorner(FrameNotification, 8)

local TitleNotification = Instance.new("TextLabel")
TitleNotification.Name = "TitleNotification"
TitleNotification.Font = Enum.Font.GothamBold
TitleNotification.TextSize = 13
TitleNotification.TextColor3 = THEME.Accent
TitleNotification.Size = UDim2.new(1, -10, 0, 25)
TitleNotification.Position = UDim2.new(0, 10, 0, 0)
TitleNotification.BackgroundTransparency = 1
TitleNotification.TextXAlignment = Enum.TextXAlignment.Left
TitleNotification.Parent = FrameNotification

local MgsNotification = Instance.new("TextLabel")
MgsNotification.Name = "MgsNotification"
MgsNotification.Font = Enum.Font.Gotham
MgsNotification.TextSize = 12
MgsNotification.TextColor3 = THEME.Text
MgsNotification.Size = UDim2.new(1, -20, 0, 30)
MgsNotification.Position = UDim2.new(0, 10, 0, 25)
MgsNotification.BackgroundTransparency = 1
MgsNotification.TextXAlignment = Enum.TextXAlignment.Left
MgsNotification.TextWrapped = true
MgsNotification.Parent = FrameNotification

-- Notification Logic
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local function showNotification(title, message, duration)
    task.spawn(function()
        local Var = FrameNotification:Clone()
        Var.Parent = MenuGUI
        Var.TitleNotification.Text = title
        Var.MgsNotification.Text = message
        Var.Visible = true
        
        local tweenIn = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(1, -230, 0, 20)})
        tweenIn:Play()
        tweenIn.Completed:Wait()
        
        task.wait(duration or 4)
        
        local tweenOut = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(1, 10, 0, 20)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        Var:Destroy()
    end)
end

-- Khóa/Mở Nút
local function LockButtonEnabled(button, enabled)
    button.Interactable = enabled
    button.Active = enabled
    button.AutoButtonColor = enabled

    if enabled then
        button.BackgroundColor3 = THEME.Button
        button.TextTransparency = 0
        button.BackgroundTransparency = 0
    else
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        button.TextTransparency = 0.5
        button.BackgroundTransparency = 0.2
    end
end

-- Thiết Kế Hệ Thống Nút & Tab
local ButtonTop = {}
ButtonTop.__index = ButtonTop

function ButtonTop.addButton(Name)
    local Child = {}
    Child.button = textButton:Clone()
    Child.button.Text = Name
    Child.button.Parent = MenuScrolling
    
    Child.Frame = Scrolling:Clone()
    Child.Frame.Parent = frame
    
    Child.button.MouseButton1Click:Connect(function()
        for _, i in ipairs(frame:GetChildren()) do
            if i:IsA("ScrollingFrame") and i.Name ~= "MenuScrolling" then 
                i.Visible = false 
            end
        end
        Child.Frame.Visible = true
    end)
    
    setmetatable(Child, ButtonTop)
    return Child.Frame
end

local function addToggle(Text, Callback)
    local Enabled = false
    local buttonToggle = textButton:Clone()
    buttonToggle.Text = Text .. " : OFF"
    buttonToggle.TextColor3 = THEME.ToggleOff
    
    buttonToggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            buttonToggle.Text = Text .. " : ON"
            buttonToggle.TextColor3 = THEME.ToggleOn
        else
            buttonToggle.Text = Text .. " : OFF"
            buttonToggle.TextColor3 = THEME.ToggleOff
        end
        if Callback then task.spawn(Callback, Enabled) end
    end)
    return buttonToggle
end

local function addClickButton(Text, Callback)
    local ClickBtn = textButton:Clone()
    ClickBtn.Text = Text
    ClickBtn.MouseButton1Click:Connect(function()
        if Callback then task.spawn(Callback) end
    end)
    return ClickBtn
end

local function addTextBox(Placeholder)
    local NewTextBox = textTextBox:Clone()
    NewTextBox.PlaceholderText = Placeholder
    NewTextBox.Text = ""
    
    NewTextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            -- Xử lý dữ liệu khi người dùng ấn Enter
        end
    end)
    return NewTextBox
end

local function SearchButton(listBase)
    local Output = {
        SelectedValue = listBase[1] or "",
        MainButton = nil,               
        DropdownList = nil
    }
    
    local Frameem = frameTop:Clone()
    local textButtonFind = textButton:Clone()
    textButtonFind.Text = listBase[1] or "Select Option..."
    textButtonFind.Size = UDim2.new(1, 0, 1, 0)
    textButtonFind.Parent = Frameem
    Output.MainButton = textButtonFind
    
    local ScrollingList = Scrolling:Clone()
    ScrollingList.Parent = frame
    ScrollingList.Size = UDim2.new(0, 180, 0, 120)
    ScrollingList.ZIndex = 20
    ScrollingList.BackgroundColor3 = THEME.Background
    Output.DropdownList = ScrollingList
    
    local function updateDropdownPosition()
        local absPosFrame = frame.AbsolutePosition
        local absPosButton = textButtonFind.AbsolutePosition
        local offsetX = absPosButton.X - absPosFrame.X
        local offsetY = absPosButton.Y - absPosFrame.Y + textButtonFind.AbsoluteSize.Y + 4
        ScrollingList.Position = UDim2.new(0, offsetX, 0, offsetY)
    end
    
    for _, i in ipairs(listBase) do
        local ButtonInto = textButton:Clone()
        ButtonInto.Text = i
        ButtonInto.ZIndex = 21
        ButtonInto.Parent = ScrollingList
        ButtonInto.MouseButton1Click:Connect(function()
            textButtonFind.Text = ButtonInto.Text
            Output.SelectedValue = ButtonInto.Text
            ScrollingList.Visible = false
        end)
    end
    
    textButtonFind.MouseButton1Click:Connect(function()
        if not ScrollingList.Visible then
            updateDropdownPosition() 
        end
        ScrollingList.Visible = not ScrollingList.Visible
    end)
    
    return Frameem, Output
end

-- Logic Kéo Trượt Window (Drag GUI)
local function keotheochuot(Button, framemove)
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        framemove.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
    
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = framemove.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Events Bắt Đầu Kéo Trượt
Icon.MouseButton1Up:Connect(function()
    frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Up:Connect(function()
    frame.Visible = false
end)

keotheochuot(Icon, frameIcon)
keotheochuot(Title, frame)

local espObjects = {}
local playerConnections={}
local SetAim={
    AIM_ASSIST_ENABLED = false,
    Target="HumanoidRootPart",
    Target_Var=Vector3.new(0,0,0),
    TargetVisible = false,
    Predicted=false,
    FOV_RADIUS = 150
}
local eng={
    AimBot_Button=false,
    tam=false,
    Fov=false
}

local AimBot_Button1=frame:Clone()
AimBot_Button1.Position=UDim2.new(0.6, 0, 0.2, 0)
AimBot_Button1.Size=UDim2.new(0.2,0,0.1,0)
AimBot_Button1.Visible=eng.AimBot_Button
AimBot_Button1.Parent=MenuGUI

local keo_tha=textButton:Clone()
keo_tha.Text=""
keo_tha.Position=UDim2.new(0,0,0,0)
keo_tha.Size=UDim2.new(1,0,0.2,0)
keo_tha.Parent=AimBot_Button1

local cl=addToggle("Aim Bot",function(en)
    SetAim.AIM_ASSIST_ENABLED=en
end)
cl.Position=UDim2.new(0,0,0.2,0)
cl.Size=UDim2.new(1,0,0.8,0)
cl.Parent=AimBot_Button1

keotheochuot(keo_tha,AimBot_Button1)

local tam = Instance.new("Frame")
tam.Name = "Tam"
tam.AnchorPoint = Vector2.new(0.5, 0.5)
tam.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Đặt vào trung tâm màn hình
tam.Size = UDim2.new(0, 5, 0,5)
tam.BorderSizePixel = 1
tam.Visible=eng.tam
tam.Parent = MenuGUI

local fovFrame = Instance.new("Frame")
fovFrame.Name = "FOVCircle"
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5) -- Đặt điểm mốc ở chính giữa khung
fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Đặt vào trung tâm màn hình
fovFrame.Size = UDim2.new(0, SetAim.FOV_RADIUS * 2, 0, SetAim.FOV_RADIUS * 2)
fovFrame.BackgroundTransparency = 1 
fovFrame.BorderSizePixel = 0
fovFrame.Visible=eng.Fov
fovFrame.Parent = MenuGUI

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255,0,0) 
uiStroke.Thickness = 1.5 
uiStroke.Transparency = 0.5
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = fovFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0) 
uiCorner.Parent = fovFrame

local aspectRatio = Instance.new("UIAspectRatioConstraint")
aspectRatio.AspectRatio = 1
aspectRatio.Parent = fovFrame

local function isTargetVisible(camera, targetPart, ignoreList)
    local origin = camera.CFrame.Position
    local targetPos = targetPart.Position
    local direction = targetPos - origin --vector huong tu camera den target
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude or Enum.RaycastFilterType.Blacklist
    
    -- Bỏ qua bản thân người chơi local và nhân vật mục tiêu (chỉ kiểm tra vật cản môi trường)
    raycastParams.FilterDescendantsInstances = ignoreList 
    
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    
    return raycastResult==nil
end

local function getTargetClosestToCrosshair(Var)
    local closestTarget = nil
    local shortestDistance = SetAim.FOV_RADIUS
    local viewportCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local targetPart = nil
            
            if Var == "Head" then 
                targetPart = character:FindFirstChild("Head")
            else
                targetPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
            end   
            if humanoid and humanoid.Health > 0 then
                local screenPosition, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                
                if onScreen then
                    
                    if SetAim.TargetVisible then if not isTargetVisible(Camera,targetPart,{Character,targetPart.Parent,Camera}) then continue end end
                    
                    local targetPos2D = Vector2.new(screenPosition.X, screenPosition.Y)
                    local distanceFromCenter = (targetPos2D - viewportCenter).Magnitude
                    
                    if distanceFromCenter < shortestDistance then
                        shortestDistance = distanceFromCenter
                        closestTarget = targetPart
                    end
                end
            end
        end
    end
    return closestTarget,shortestDistance
end

RunService.RenderStepped:Connect(function(deltaTime)
    if SetAim.AIM_ASSIST_ENABLED then
        local target,Distance = getTargetClosestToCrosshair()
        if target then
            local targetPosition=target.Position
            if SetAim.Predicted then
                local targetChar = target.Parent
                local hrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                local predictionTime = 0.136 -- Thời gian dự đoán (giây), điều chỉnh tùy thuộc vào Ping
                    
                if hrp then
                    targetPosition = target.Position + (hrp.AssemblyLinearVelocity * predictionTime)
                end
            end
            local currentCFrame = Camera.CFrame
            local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
            local smoothness = (Distance <= 0.25) and 0.1 or 0.5
            local alpha = 1 - math.exp(-smoothness * deltaTime * 60)
            Camera.CFrame = currentCFrame:Lerp(targetCFrame, alpha)
        end
    end
end)
local function applyESP_1(player)
    if player == LocalPlayer then return end
    
    local box = Drawing.new("Square")
    box.Thickness = 1.5
    box.Filled = false
    box.Color = Color3.fromRGB(255, 0, 0) or player.TeamColor
    box.Visible = false

    local healthBar = Drawing.new("Square")
    healthBar.Thickness = 1
    healthBar.Filled = true
    healthBar.Color = Color3.fromRGB(0, 255, 0)
    healthBar.Visible = false

    local nameText = Drawing.new("Text")
    nameText.Size = 12
    nameText.Center = true
    nameText.Outline = true
    nameText.Color = Color3.fromRGB(255, 255, 255)
    nameText.Visible = false
    
    local renderConnection
    renderConnection = RunService.RenderStepped:Connect(function()
        
        local character = player.Character
        if not character then 
            box.Visible = false
            healthBar.Visible = false
            nameText.Visible = false
            return 
        end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if hrp and humanoid and humanoid.Health > 0 then
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)

            if onScreen then
                local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
                local height = (Camera.ViewportSize.Y / distance) * 2.5
                local width = height * 0.65

                local posX = vector.X - (width / 2)
                local posY = vector.Y - (height / 2)
                
                box.Size = Vector2.new(width, height)
                box.Position = Vector2.new(posX, posY)
                box.Visible = true
                
                local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                local barHeight = height * healthPercent

                healthBar.Size = Vector2.new(2, barHeight)
                healthBar.Position = Vector2.new(posX - 5, posY + (height - barHeight))
                healthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                healthBar.Visible = true
                
                nameText.Text = player.Name
                nameText.Position = Vector2.new(vector.X, posY - 16)
                nameText.Visible = true
                return
            end
        end
        
        box.Visible = false
        healthBar.Visible = false
        nameText.Visible = false
    end)
    
    espObjects[player] = {
        Box = box,
        HealthBar = healthBar,
        Name = nameText,
        Connection = renderConnection
    }
end

local function remoESP_1(player)
    local data = espObjects[player]
    if data then
        if data.Connection then data.Connection:Disconnect() end
        if data.Box then data.Box:Remove() end
        if data.HealthBar then data.HealthBar:Remove() end
        if data.Name then data.Name:Remove() end
        espObjects[player] = nil
    end
end

local function applyESP(character)
    if not character or character == LocalPlayer.Character then showNotification("err","loi than nhan vat") return end
    
    local oldHighlight = character:FindFirstChildOfClass("Highlight")
    if oldHighlight then oldHighlight:Destroy() end
    
    local oldGui = character:FindFirstChildOfClass("BillboardGui")
    if oldGui then oldGui:Destroy() end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "TeamESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0) or player.TeamColor
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_InfoGui"
    billboard.Adornee = head
    billboard.Size = UDim2.new(5, 0, 6, 0)
    billboard.StudsOffset = Vector3.new(0, 0.5, 0) -- Độ cao trên đầu
    billboard.AlwaysOnTop = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 15, 0, 15)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = Players:GetPlayerFromCharacter(character) and Players:GetPlayerFromCharacter(character).Name or character.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 1 -- Viền đen 
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = billboard
    
    local doll = Instance.new("Frame")
    doll.Name = "doll"
    doll.Size = UDim2.new(0.15, 0, 0.15, 0)
    doll.Position = UDim2.new(0.5-0.15/2, 0, 0.5-0.15/2, 0)
    doll.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    doll.BorderSizePixel = 1
    doll.Parent = billboard
    
    local healthBackground = Instance.new("Frame")
    healthBackground.Name = "HealthBG"
    healthBackground.Size = UDim2.new(0.1, 0, 1, 0)
    healthBackground.Position = UDim2.new(0, 0, 0, 0)
    healthBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    healthBackground.BorderSizePixel = 0
    healthBackground.Parent = billboard
    
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.Position = UDim2.new(0,0,0,0)
    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = healthBackground
    
    local targetPart = character:FindFirstChild("HumanoidRootPart")
    if not targetPart then
        targetPart = character:WaitForChild("HumanoidRootPart", 3)
        if not targetPart then showNotification("err","loi dau") end
    end
    billboard.Parent = character
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local function updateHealth()
            local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
            -- Co giãn chiều rộng thanh máu theo %
            healthBar.Size = UDim2.new(1, 0, healthPercent, 0)
            healthBar.Position= UDim2.new(0,0,1-healthPercent,0)
            -- Tự động chuyển từ Xanh -> Đỏ khi máu thấp
            healthBar.BackgroundColor3 = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
        end
        updateHealth()
        humanoid.HealthChanged:Connect(updateHealth)
    end
end

local function remoESP(model)
    if not model then showNotification("err","loi model ") return end
    local oldHighlight = model:FindFirstChildOfClass("Highlight")
    if oldHighlight then oldHighlight:Destroy() end
    
    local oldGui = model:FindFirstChildOfClass("BillboardGui")
    if oldGui then oldGui:Destroy() end
end

local Aim_Bot=ButtonTop.addButton("Aim_bot")
local Esp=ButtonTop.addButton("Esp")
local Mic=ButtonTop.addButton("Mic")

local textFov=addTextBox("150")
textFov.Parent=Aim_Bot
textFov.LayoutOrder=0

local setFov=addClickButton("set Fov",function()
    SetAim.FOV_RADIUS = tonumber(textFov.Text)
    fovFrame.Size = UDim2.new(0, SetAim.FOV_RADIUS * 2, 0, SetAim.FOV_RADIUS * 2)
end)
setFov.Parent=Aim_Bot
setFov.LayoutOrder=1

local ShowFov=addToggle("Show Fov",function(en)
    eng.Fov=en
    fovFrame.Visible=en
end)
ShowFov.Parent=Aim_Bot
ShowFov.LayoutOrder=2

local ChoseAim_Bot,out_put_Aim_Bot=SearchButton({"Head","HumanoidRootPart"})
ChoseAim_Bot.Parent = Aim_Bot
ChoseAim_Bot.LayoutOrder=3

local Check_Aim_Bot=addToggle("TargetVisible",function(Enabled)
    SetAim.TargetVisible=Enabled
end)
Check_Aim_Bot.Parent=Aim_Bot
Check_Aim_Bot.LayoutOrder=4

local Peri_Aim_Bot=addToggle("Predicted",function(Enabled)
    SetAim.Predicted=Enabled
end)
Peri_Aim_Bot.Parent=Aim_Bot
Peri_Aim_Bot.LayoutOrder=5

local Enabled_Aim_Bot=addToggle("Aim_Bot",function(Enabled)
    SetAim.AIM_ASSIST_ENABLED=Enabled
end)
Enabled_Aim_Bot.Parent=Aim_Bot
Enabled_Aim_Bot.LayoutOrder=6

local kt1=addToggle("Button Aim (mobile)",function(en)
    eng.AimBot_Button=en
    AimBot_Button1.Visible=en
end)
kt1.Parent=Aim_Bot
kt1.LayoutOrder=7

local kt2=addToggle("tam ngam",function(en)
    eng.tam=en
    tam.Visible=en
end)
kt2.Parent=Aim_Bot
kt2.LayoutOrder=8

local ChoseEsp,out_put_1=SearchButton({"Type_1","Type_2"})
ChoseEsp.Parent = Esp
ChoseEsp.LayoutOrder=10

local tolEsp = addToggle("ESP_Play", function(Enabled)
    if out_put_1.SelectedValue=="Type_2" then
        if Enabled then
            LockButtonEnabled(out_put_1.MainButton, false)
            local function setupPlayer(player)
                if player == LocalPlayer then return end
                if player.Character then applyESP(player.Character) end
                local charCon = player.CharacterAdded:Connect(function(char) applyESP(char) end)
                table.insert(playerConnections, charCon)
            end
            for _, player in ipairs(Players:GetPlayers()) do
                setupPlayer(player)
            end
            local joinCon = Players.PlayerAdded:Connect(setupPlayer)
            table.insert(playerConnections, joinCon)
            
        else
            LockButtonEnabled(out_put_1.MainButton, true)
            for _, conn in ipairs(playerConnections) do
                conn:Disconnect()
            end
            table.clear(playerConnections)
            for _, player in ipairs(Players:GetPlayers()) do
                remoESP(player.Character)
            end
        end
    else
        if Enabled then
            LockButtonEnabled(out_put_1.MainButton, false)
            for _,player in ipairs(Players:GetPlayers()) do
                applyESP_1(player)
            end
        else
            LockButtonEnabled(out_put_1.MainButton, true)
            for _,player in ipairs(Players:GetPlayers()) do
                remoESP_1(player)
            end
        end
    end
end)
tolEsp.Parent = Esp
tolEsp.LayoutOrder=11

