local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Tạo GUI 
local MenuGUI = Instance.new("ScreenGui")
MenuGUI.Name = "MenuGUI"
MenuGUI.DisplayOrder = 0
MenuGUI.IgnoreGuiInset = true
MenuGUI.ResetOnSpawn = false
MenuGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frameIcon = Instance.new("Frame")
frameIcon.Name="frameIcon"
frameIcon.Size=UDim2.new(0, 20, 0, 20)
frameIcon.Position=UDim2.new(0.08, 0, 0.2, 0)
frameIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frameIcon.BorderSizePixel = 1
frameIcon.BorderColor3 = Color3.fromRGB(0, 255, 255)
frameIcon.Parent=MenuGUI

local Icon = Instance.new("ImageButton")
Icon.Name = "Icon"
Icon.Size = UDim2.new(1, 0, 1, 0)
Icon.Position = UDim2.new(0, 0, 0, 0)
Icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Icon.BorderSizePixel = 1
Icon.BorderColor3 = Color3.fromRGB(0, 255, 255)
Icon.Parent = frameIcon

local frame = Instance.new("Frame")
frame.Name="frame"
frame.Size=UDim2.new(0.75, 0, 0.75, 0)
frame.Position=UDim2.new(0.18, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 1
frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
frame.Parent=MenuGUI

local Title = Instance.new("TextButton")
Title.Name = "Title"
Title.Text = "nho nhac Hub.               make by: Next :> "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0.05, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 1
Title.BorderColor3 = Color3.fromRGB(0, 255, 255)
Title.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Name = "closeButton"
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Size = UDim2.new(0.05, 0, 1, 0)
closeButton.Position = UDim2.new(0.95, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeButton.BorderSizePixel = 1
closeButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
closeButton.Parent = Title

local MenuScrolling = Instance.new("ScrollingFrame")
MenuScrolling.Name = "MenuScrolling"
MenuScrolling.Size = UDim2.new(0.2, 0, 0.95, 0)
MenuScrolling.Position = UDim2.new(0, 0, 0.05, 0)
MenuScrolling.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MenuScrolling.BorderColor3 = Color3.fromRGB(0, 255, 255)
MenuScrolling.BorderSizePixel = 1
MenuScrolling.ScrollBarThickness = 0
MenuScrolling.Parent = frame

-- 🌟 Thêm UIListLayout vào Menu Thang Cuộn Trái để tự động xếp nút bấm
local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Padding = UDim.new(0, 2) -- Khoảng cách giữa các nút là 2 pixel
LeftListLayout.Parent = MenuScrolling

local textButton = Instance.new("TextButton")
textButton.Name = "Button"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.Size = UDim2.new(1, 0, 0, 35)
textButton.Position = UDim2.new(0, 0, 0, 0)
textButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textButton.BorderSizePixel = 1
textButton.BorderColor3 = Color3.fromRGB(0, 255, 255)

local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Name = "Scrolling"
Scrolling.Size = UDim2.new(0.8, 0, 0.95, 0)
Scrolling.Position = UDim2.new(0.2, 0, 0.05, 0)
Scrolling.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Scrolling.BorderSizePixel = 1
Scrolling.BorderColor3 = Color3.fromRGB(0, 255, 255)
Scrolling.ScrollBarThickness = 0
Scrolling.Visible = false
Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

-- 🌟 Thêm UIListLayout vào Khung Nội Dung Mẫu để sau này các tính năng bên trong tự xếp hàng thẳng thớm
local RightListLayout = Instance.new("UIListLayout")
RightListLayout.Padding = UDim.new(0, 5)
RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
RightListLayout.Parent = Scrolling
RightListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end)

local textTextBox = Instance.new("TextBox")
textTextBox.Name = "TextBox"
textTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textTextBox.Size = UDim2.new(1, 0, 0, 35)
textTextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textTextBox.BorderSizePixel = 1
textTextBox.BorderColor3 = Color3.fromRGB(0, 255, 255)
textTextBox.Font = Enum.Font.SourceSans
textTextBox.TextSize = 14
textTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)

local frameTop = Instance.new("Frame")
frameTop.Name="frameTop"
frameTop.Size=UDim2.new(1, 0, 0, 35)
frameTop.Position=UDim2.new(0, 0, 0, 0)
frameTop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frameTop.BorderSizePixel = 1
frameTop.BorderColor3 = Color3.fromRGB(0, 255, 255)

local textLabelTop = Instance.new("TextLabel")
textLabelTop.Name="textLabelTop"
textLabelTop.Size=UDim2.new(0, 0, 0, 0)
textLabelTop.Position=UDim2.new(0, 0, 0, 0)
textLabelTop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabelTop.BorderSizePixel = 1
textLabelTop.BorderColor3 = Color3.fromRGB(0, 255, 255)

--Notification
local FrameNotification = Instance.new("Frame")
FrameNotification.Name="FrameNotification"
FrameNotification.Size=UDim2.new(0.2, 0, 0.1, 0)
FrameNotification.Position=UDim2.new(1, 0, 0, 0)
FrameNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FrameNotification.Visible = false

local TitleNotification = Instance.new("TextLabel")
TitleNotification.Name="TitleNotification"
TitleNotification.TextColor3=Color3.fromRGB(255, 255, 255)
TitleNotification.Size=UDim2.new(1,0,0.4,0)
TitleNotification.Position=UDim2.new(0,0,0,0)
TitleNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleNotification.Parent = FrameNotification

local MgsNotification = Instance.new("TextLabel")
MgsNotification.Name="MgsNotification"
MgsNotification.TextColor3=Color3.fromRGB(255, 255, 255)
MgsNotification.Size=UDim2.new(1,0,0.6,0)
MgsNotification.Position=UDim2.new(0,0,0.4,0)
MgsNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MgsNotification.Parent=FrameNotification

--MgsNotification
local tweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
local function showNotification(title, message, duration)
  local Var=FrameNotification:Clone()
  Var.Parent = MenuGUI
  Var.TitleNotification.Text=title
  Var.MgsNotification.Text=message
  Var.Visible=true
  local tweenIn = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(0.8,0,0,0)})
  tweenIn:Play()
  tweenIn.Completed:Wait()
  task.wait(duration or 5)
  local tweenOut = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(1, 0, 0, 0)})
  tweenOut:Play()
  tweenOut.Completed:Wait()
  Var:Destroy()
end

local function LockButtonEnabled(button, enabled)
    button.Interactable = enabled
    button.Active = enabled
    button.AutoButtonColor = enabled -- Tắt hiệu ứng đổi màu khi di chuột vào

    if enabled then
        button.BackgroundColor3 = Color3.fromRGB(0,0,0) -- Màu chính
        button.TextTransparency = 0
        button.BackgroundTransparency = 0
    else
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Màu xám
        button.TextTransparency = 0.5
        button.BackgroundTransparency = 0.3
    end
end

--thiet keu nut bam
local ButtonTop={}
ButtonTop.__index = ButtonTop
function ButtonTop.addButton(Name)
  local Child={}
  Child.button=textButton:Clone()
  Child.button.Text=Name
  Child.button.Parent=MenuScrolling
  Child.Frame=Scrolling:Clone()
  Child.Frame.Parent=frame
  Child.button.MouseButton1Click:Connect(function()
    for _,i in ipairs(frame:GetChildren()) do
      if i:IsA("ScrollingFrame") and i.Name~="MenuScrolling" then i.Visible=false end
    end
    Child.Frame.Visible=true
  end)
  setmetatable(Child, ButtonTop)
  return Child.Frame
end

local function addToggle(Text, Callback)
  local Enabled = false
  local buttonToggle = textButton:Clone()
  buttonToggle.Text=Text..":OFF"
  buttonToggle.TextColor3 = Color3.fromRGB(255, 100, 100)  
  buttonToggle.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
      buttonToggle.Text=Text..":ON"
      buttonToggle.TextColor3 = Color3.fromRGB(100, 255, 100)  
    else
      buttonToggle.Text=Text..":OFF"
      buttonToggle.TextColor3 = Color3.fromRGB(255, 100, 100)  
    end
    if Callback then task.spawn(Callback,Enabled) end
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
  NewTextBox.Text = Placeholder
  -- Khi người chơi nhập xong và nhấn Enter
  NewTextBox.FocusLost:Connect(function(enterPressed)
      NewTextBox.Text = enterPressed
  end)
    return NewTextBox
end

local function SearchButton(listBase)
  local Output={
    SelectedValue = listBase[1] or "",
    MainButton = nil,               
    DropdownList = nil
  }
  local Frameem = frameTop:Clone()
  Frameem.Parent=parent  
  local textButtonFind = textButton:Clone()
  textButtonFind.Text=  "....."
  textButtonFind.Size = UDim2.new(1, 0, 1, 0)
  textButtonFind.Parent = Frameem
  Output.MainButton=textButtonFind
  local ScrollingList = Scrolling:Clone()
  ScrollingList.Parent = frame
  ScrollingList.Size=UDim2.new(0.4, 0, 0.4, 0)
  ScrollingList.ZIndex = 20
  Output.DropdownList = ScrollingList
  local function updateDropdownPosition()
    -- Tính toán vị trí thực tế của ô bấm đối với khung frame lớn
    local absPosFrame = frame.AbsolutePosition
    local absPosButton = textButtonFind.AbsolutePosition
    local offsetX = absPosButton.X - absPosFrame.X
    local offsetY = absPosButton.Y - absPosFrame.Y + textButtonFind.AbsoluteSize.Y
    ScrollingList.Position = UDim2.new(0, offsetX, 0, offsetY)
  end
  for _,i in ipairs(listBase) do
    local ButtonInto = textButton:Clone()
    ButtonInto.Text = i
    ButtonInto.ZIndex = 20
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
  return Frameem,Output
end

local function keotheochuot(Button,framemove)
  local dragging = false
  local dragInput
  local dragStart
  local startPos
    
  local function update(input)
    local delta = input.Position - dragStart
    framemove.Position = UDim2.new(
    startPos.X.Scale,
    startPos.X.Offset + delta.X,
    startPos.Y.Scale,
    startPos.Y.Offset + delta.Y)
  end
  
  Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = framemove.Position
      local connection
      connection=input.Changed:Connect(function()
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

Icon.MouseButton1Up:Connect(function()
  frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Up:Connect(function()
  frame.Visible = false
end)

--set up menu
keotheochuot(Icon,frameIcon)
keotheochuot(Title,frame)
