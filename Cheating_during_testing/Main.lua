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
local Walls = Class:WaitForChild("Build",3)
local SizeWall = Walls:GetExtentsSize()
local room = Walls:GetPivot() 

local FrameMap=frameTop:Clone()
FrameMap.Size=UDim2.new(0.2,0,0.2*0.8*SizeWall.Z/SizeWall.X,0)
FrameMap.Position=UDim2.new(0.5,0,0.5,0)
FrameMap.Visible=false
FrameMap.Parent=MenuGUI

local Title_Map=textButton:Clone()
Title_Map.Size=UDim2.new(1,0,0.2,0)
Title_Map.Position=UDim2.new(0,0,0,0)
Title_Map.Parent=FrameMap

local Map=frameTop:Clone()
Map.Size=UDim2.new(1,0,0.8,0)
Map.Position=UDim2.new(0,0,0.2,0)
Map.Parent=FrameMap

keotheochuot(Title_Map,FrameMap)

local circle = Instance.new("Frame")
circle.Name = "Circle"
circle.Size = UDim2.new(0,5,0,5)
circle.AnchorPoint = Vector2.new(0.5,0.5)
circle.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
local vec_look = Instance.new("Frame")
vec_look.Name="look"
vec_look.Size = UDim2.new(0,2.5,0,7.5)
vec_look.AnchorPoint = Vector2.new(0.5,1)
vec_look.Position = UDim2.new(0.5,0,0.5,0)
vec_look.Parent=circle
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

local function getPlayerRotation(characterModel)
    local Head = characterModel:FindFirstChild("Head")
    if not Head then showNotification("err","loi Head") return end
    local lookVector = Head:GetPivot().LookVector
    local angleInRadians = math.atan2(lookVector.X, lookVector.Z)
    local angleInDegrees = math.deg(angleInRadians)
    return -angleInDegrees
end

local function update(play,teacher)
    local Play_Po=Character:GetPivot()
    if Play_Po and play then
        play.Position = UDim2.new(0.5-(Play_Po.X-room.X)/SizeWall.X,0,0.5-(Play_Po.Z-room.Z)/SizeWall.Z,0)
        play.Rotation = getPlayerRotation(Character)
    end
    local Teacher=Workspace:FindFirstChild("Teacher")
    if Teacher and teacher then
        Teacher_Po = Teacher:GetPivot()
        teacher.Position = UDim2.new(0.5-(Teacher_Po.X-room.X)/SizeWall.X,0,0.5-(Teacher_Po.Z-room.Z)/SizeWall.Z,0)
        teacher.Rotation = getPlayerRotation(Teacher)
    end
end

local function show_dest(dest)
    local list1={}
    for _,i in ipairs(dest:GetChildren()) do
        if i:IsA("Model") and i.Name=="Desk" then
            local Size=i:GetExtentsSize()
            local Po=i:GetPivot()
            local desk1=desk:Clone()
            desk1.Size=UDim2.new(Size.X/SizeWall.X,0,Size.Z/SizeWall.Z,0)
            desk1.Position=UDim2.new(0.5-(Po.X-room.X)/SizeWall.X,0,0.5-(Po.Z-room.Z)/SizeWall.Z,0)
            desk1.Parent=Map
            table.insert(list1,desk1)
        end
    end
    return list1
end

local playInstance = nil
local teacherInstance = nil
local map_open = nil
local list_desk= nil

ButMap=addToggle("Show Map",function (ed)
    FrameMap.Visible=ed
    if ed then
        local roomContainer = Class:FindFirstChild("Room")
        local room2 = roomContainer and (roomContainer:FindFirstChild("Room2") or roomContainer:FindFirstChild("Room1"))
        if not room2 then showNotification("err","chua tim thay room")
        else
            list_desk=show_dest(room2)
        end
        playInstance = circle:Clone()
        playInstance.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        playInstance.Parent = Map
        teacherInstance = circle:Clone()
        teacherInstance.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        teacherInstance.Parent = Map
        map_open=task.spawn(function()
            while true do
                update(playInstance, teacherInstance)
                task.wait(0.1)
            end
        end)
    else
        if map_open then task.cancel(map_open) map_open = nil end
        if playInstance then playInstance:Destroy() playInstance = nil end
        if teacherInstance then teacherInstance:Destroy() teacherInstance = nil end
        if list_desk then
            for _,i in ipairs(list_desk) do
                i:Destroy()
            end
            list_desk = nil
        end
    end
end)
ButMap.Parent=Main

