local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

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

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, radius or 6)

local function addCorner(parent, radius)
    local corner1 = corner:Clone()
    corner1.Parent = parent
    return corner1
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
addCorner(Title,10)

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
MenuScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
MenuScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
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

local Main = ButtonTop.addButton("Main")
local Mis = ButtonTop.addButton("Mis")

local Class = workspace:WaitForChild("Classroom")

local FrameMap=frameTop:Clone()
FrameMap.Size=UDim2.new(0,150,0,150)
FrameMap.Position=UDim2.new(0.5,0,0.5,0)
FrameMap.BackgroundTransparency=0.35
FrameMap.Visible=false
FrameMap.Parent=MenuGUI

local Title_Map=textButton:Clone()
Title_Map.Size=UDim2.new(1,0,0.2,0)
Title_Map.Position=UDim2.new(0,0,-0.2,0)
Title_Map.Parent=FrameMap

local Map=frameTop:Clone()
Map.Size=UDim2.new(1,0,1,0)
Map.Position=UDim2.new(0,0,0,0)
Map.Parent=FrameMap
local mapCo=Map:FindFirstChild("UICorner")
if mapCo then mapCo.CornerRadius=UDim.new(1,0) end

keotheochuot(Title_Map,FrameMap)

local circle = Instance.new("Frame")
circle.Name = "Circle"
circle.Size = UDim2.new(0,5,0,5)
circle.AnchorPoint = Vector2.new(0.5,0.5)
circle.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
local vec_look = Instance.new("Frame")
vec_look.Name="look"
vec_look.Size = UDim2.new(0,2.5,0,7.5)
vec_look.AnchorPoint = Vector2.new(0.5,1)
vec_look.Position = UDim2.new(0.5,0,0.5,0)
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent=circle

local desk = Instance.new("Frame")
desk.AnchorPoint = Vector2.new(0.5,0.5)
desk.BackgroundTransparency = 1
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 0, 255)
uiStroke.Thickness = 1
uiStroke.Parent = desk

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local toolEvents = ReplicatedStorage:WaitForChild("ToolEvents")
local playAnimRemote = toolEvents:WaitForChild("PlayAnimation")
local toolActionRemote = toolEvents:WaitForChild("ToolAction")
local PlayerAnswerTable = ReplicatedStorage:WaitForChild("PlayerAnswerTable")
local backPack = LocalPlayer:WaitForChild("Backpack")

local playInstance1 = circle:Clone()
playInstance1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
playInstance1.Position = UDim2.new(0.5,0,0.5,0)
playInstance1.Size = UDim2.new(0,8,0,8)
playInstance1.Parent = Map
local play_look=vec_look:Clone()
play_look.Parent=playInstance1

local teacherInstance1 = circle:Clone()
teacherInstance1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
teacherInstance1.Size = UDim2.new(0,8,0,8)
teacherInstance1.Parent = Map
local teacher_look=vec_look:Clone()
teacher_look.Parent=playInstance1

local Play = { CFrame = nil, Position = nil, Rotation = nil }
local Teacher = { CFrame = nil, Position = nil, Rotation = nil }

local Mini_Map = {
    fov=60,
    length=300,
    playInstance = playInstance1,
    teacherInstance = teacherInstance1,
    list_desk = {},
    list_play = {}
}

local Gui = {
    map_open = false,
    autoFarme = false
}

local Main1 = {
    auto_Farme = nil,
    count = 0,
    answer = nil,
    seat = nil,
    len = 0,
    anxiety = {
        nub=nil,
        var=false
    }
}

local anxiety = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("StatGui") and LocalPlayer.PlayerGui.StatGui:FindFirstChild("Anxiety") and LocalPlayer.PlayerGui.StatGui.Anxiety:FindFirstChild("AnxietyBarClip") and LocalPlayer.PlayerGui.StatGui.Anxiety.AnxietyBarClip:FindFirstChild("AnxietyBar")
if not anxiety then showNotification("err","loi gui") 
else
    Main1.anxiety.nub=anxiety
end

local function huong_nh(CFrame1,CFrame2,huong)
    local var=0
    local deltaX=(CFrame1.X-CFrame2.X)
    local deltaY=(CFrame1.Z-CFrame2.Z)
    local angleInRadians = math.atan2(deltaX,deltaY)
    local angleInDegrees = math.deg(angleInRadians)
    local angleInDegrees = -(angleInDegrees+90+Mini_Map.fov)%360
    local angleInDegrees1 = -(angleInDegrees-2*Mini_Map.fov)%360
    if angleInDegrees>huong and angleInDegrees1<huong then return true end
    return false 
end

local function getPlayerRotation(characterModel)
    if not characterModel then return 0 end
    local Head = characterModel:FindFirstChild("Head")
    if not Head then 
        showNotification("err", "loi Head của " .. characterModel.Name) 
        return 0 
    end
    local lookVector = Head:GetPivot().LookVector
    local angleInRadians = math.atan2(lookVector.X, lookVector.Z)
    local angleInDegrees = math.deg(angleInRadians)
    return -angleInDegrees
end

local function update()
    local Play_Po = Character:GetPivot()
    if Play_Po then
        Play.CFrame = Play_Po
        Play.Position = UDim2.new(0.5, 0, 0.5, 0)
        Play.Rotation = getPlayerRotation(Character)
    else
        showNotification("err", "khong thay play")
    end

    local Teacher1 = Workspace:FindFirstChild("Teacher")
    if Teacher1 then
        local Teacher_Po = Teacher1:GetPivot()
        Teacher.CFrame = Teacher_Po
        Teacher.Position = UDim2.new(0.5+(Play_Po.X-Teacher_Po.X)/Mini_Map.length*2,0, 0.5+(Play_Po.Z-Teacher_Po.Z)/Mini_Map.length*2,0) or UDim2.new(0,0,0,0)
        Teacher.Rotation = getPlayerRotation(Teacher1)
    end
end

local function show_Mini(dest)
    local list1 = {}
    for _,i in ipairs(Players:GetChildren()) do
        local playvar=i.Character
        if not playvar then return end
        if i ~= LocalPlayer and not Mini_Map.list_play[i.Name] then
            local CFrameplay=playvar:GetPivot()
            local human = circle:Clone()
            human.Position = UDim2.new(0.5+(Play.CFrame.X-CFrameplay.X)/Mini_Map.length*2,0, 0.5+(Play.CFrame.Z-CFrameplay.Z)/Mini_Map.length*2,0)
            human.Parent = Map
            Mini_Map.list_play[i.Name]=human
        end
    end
    for _, i in ipairs(dest:GetChildren()) do
        if i:IsA("Model") and i.Name == "Desk" then
            local Size = i:GetExtentsSize()
            local Po = i:GetPivot()
            if desk then
                local desk1 = desk:Clone()
                desk1.Size = UDim2.new(Size.X / 150, 0, Size.Z / 150, 0)
                desk1.Position = UDim2.new(0.5+(Play.CFrame.X-Po.X)/Mini_Map.length*2,0, 0.5+(Play.CFrame.Z-Po.Z)/Mini_Map.length*2,0)
                desk1.Parent = Map
                table.insert(list1, desk1)
            end
        end
    end
    return list1
end

local function tool_Equit(toolName)
    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    if toolName == "" then
        if humanoid then humanoid:UnequipTools() end
        return
    end
    local var=Character:FindFirstChild(toolName)
    if var then return end
    local monDo = backPack:FindFirstChild(toolName)
    if humanoid and monDo then
        humanoid:EquipTool(monDo)
    else
        showNotification("err", "Không tìm thấy nhân vật hoặc công cụ: " .. toolName)
    end
end

local function auto_Farme_Logic()
    if not playAnimRemote or not toolActionRemote then return end
    local var = 1
    playAnimRemote:FireServer("Phone1", "Use")
    toolActionRemote:FireServer("Phone1", "Use")
    task.wait(2)
    
    playAnimRemote:FireServer("Phone1", "SecondUse")
    toolActionRemote:FireServer("Phone1", "SecondUse")
    task.wait(3)
    
    playAnimRemote:FireServer("Phone1", "Idle")
    toolActionRemote:FireServer("Phone1", "Unequip")
    playAnimRemote:FireServer("Phone1", "stop")
    task.wait(0.2)
    if Main1.answer and Main1.answer.Text then
        local ansTable = string.split(Main1.answer.Text, "\n")
        for _, i in ipairs(ansTable) do
            local fe = string.gsub(i,"%.","")
            local j=string.split(fe," ")
            print(j[1],j[2])
            var=tonumber(j[1])
            if var then 
                PlayerAnswerTable:InvokeServer(var,j[2]) 
            else
                showNotification("err","loi so")
            end
        end
    end
    return var
end

ButMap = addToggle("Show Map", function(ed)
    FrameMap.Visible = ed
    Gui.map_open = ed
    if ed then
        local roomContainer = Class:FindFirstChild("Room")
        local room2 = roomContainer and (roomContainer:FindFirstChild("Room2") or roomContainer:FindFirstChild("Room1"))
        if not room2 then 
            showNotification("err", "chua tim thay room")
        else 
            Mini_Map.list_desk = show_Mini(room2)
        end
    else
        if Mini_Map.list_play then
            for _,i in ipairs(Mini_Map.list_play) do
                i:Destroy()
            end
            Mini_Map.list_play={}
        if Mini_Map.list_desk then
            for _,i in ipairs(Mini_Map.list_desk) do
                i:Destroy()
            end
            Mini_Map.list_desk = {}
        end
    end
end)
ButMap.Parent = Main

autoFarmeBtn = addToggle("Auto Farme", function(ed)
    Gui.autoFarme = ed
    if not ed and Main1.auto_Farme then
        task.cancel(Main1.auto_Farme)
        Main1.auto_Farme = nil
        playAnimRemote:FireServer("Phone1", "stop")
        tool_Equit("Pencil")
    end
end)
autoFarmeBtn.Parent = Main

RunService.RenderStepped:Connect(function()
    update()
    if Gui.map_open then
        if Mini_Map.playInstance then
            Mini_Map.playInstance.Rotation=Play.Rotation
            Map.Rotation = -Play.Rotation
        end
        if Mini_Map.teacherInstance then
            Mini_Map.teacherInstance.Position = Teacher.Position
            Mini_Map.teacherInstance.Rotation = Teacher.Rotation
        end
    end
    if Gui.autoFarme and Main1.seat and Play.CFrame and Teacher.CFrame then
        if Main1.anxiety.nub and (Main1.anxiety.nub.Size.X.Scale>=0.9 or Main1.anxiety.var) then
            Main1.anxiety.var=true
            if Main1.anxiety.nub.Size.X.Scale<=0.5 then Main1.anxiety.var=false end
            if Main1.auto_Farme then 
                task.cancel(Main1.auto_Farme) 
                Main1.auto_Farme = nil 
            end
            playAnimRemote:FireServer("Phone1", "stop")
            tool_Equit("Pencil")
            return
        end
        local distance = (Play.CFrame.Position - Teacher.CFrame.Position).Magnitude
        if distance > 28 or (distance >= 10 and huong_nh(Play.CFrame,Teacher.CFrame,Teacher.Rotation))then
            if not Main1.auto_Farme then
                Main1.auto_Farme = task.spawn(function()
                    local phone = backPack:FindFirstChild("Phone1") or Character:FindFirstChild("Phone1")
                    local Answers = phone and phone:FindFirstChild("Phone") and phone.Phone:FindFirstChild("Screen") 
                        and phone.Phone.Screen:FindFirstChild("SurfaceGui") and phone.Phone.Screen.SurfaceGui:FindFirstChild("Frame") 
                        and phone.Phone.Screen.SurfaceGui.Frame:FindFirstChild("AnswersText")
                    
                    local startRound = Main1.seat:FindFirstChild("StartRoundEnv")
                    local paper = startRound and startRound:FindFirstChild("AnswerPaper") 
                        and startRound.AnswerPaper:FindFirstChild("AnswerPaperSurfaceGui") 
                        and startRound.AnswerPaper.AnswerPaperSurfaceGui:FindFirstChild("Paper")
                    
                    if not Answers or not paper then 
                        showNotification("err", "Không tìm thấy giao diện Điện thoại hoặc Tờ giấy")
                        Main1.auto_Farme = nil
                        return 
                    end
                    
                    local len = #paper:GetChildren() - 5
                    Main1.len = len
                    Main1.answer = Answers
                    if Main1.answer.Text=="" then Main1.answer.Text="1000" end
                    tool_Equit("Phone1")
                    local var=1
                    while Gui.autoFarme and Main1.seat and var and var <= Main1.len do 
                        var=auto_Farme_Logic() or 1
                    end
                    Main1.auto_Farme = nil
                end)
            end
        else
            if Main1.auto_Farme then 
                task.cancel(Main1.auto_Farme) 
                Main1.auto_Farme = nil 
            end
            playAnimRemote:FireServer("Phone1", "stop")
            tool_Equit("Pencil")
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    local humanoid = newChar:WaitForChild("Humanoid")
    humanoid.Seated:Connect(function(isSitting, seat)
        if isSitting and seat then
            Main1.seat = seat
        else
            Main1.seat = nil
        end
    end)
end)

if Character:FindFirstChild("Humanoid") then
    Character.Humanoid.Seated:Connect(function(isSitting, seat)
        if isSitting and seat then
            Main1.seat = seat
        else
            Main1.seat = nil
        end
    end)
end

Players.PlayerAdded:Connect(function(play)
    if not Gui.map_open then return end
    local char=play.Character or play.CharacterAdded:Wait()
    if not char then return end
    if play ~= LocalPlayer and not Mini_Map.list_play[play.Name] then
        local CFrameplay=char:GetPivot()
        local human = circle:Clone()
        human.Position = UDim2.new(0.5+(Play.CFrame.X-CFrameplay.X)/Mini_Map.length*2,0, 0.5+(Play.CFrame.Z-CFrameplay.Z)/Mini_Map.length*2,0)
        human.Parent = Map
        Mini_Map.list_play[play.Name]=human
    end
end)

Players.PlayerRemoving:Connect(function(play)
    local human=Mini_Map.list_play[play.Name]
    if not human then return end
    human:Destroy()
    Mini_Map.list_play[play.Name]=nil
end)
