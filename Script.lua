LightParts = Instance.new("Folder", game.Workspace)
LightParts.Name = "LightParts"

Form = Instance.new("Sound", script)
Form.Name = "Form"
Form.SoundId = "rbxassetid://9120705982"
Form.RollOffMaxDistance = 50
Form.PlaybackSpeed = 5
Form.Volume = 1
Instance.new("CompressorSoundEffect", Form)

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Char)
		wait()
		local Total, Loaded = 0, 0
		for i, Child : Instance in pairs(Char:GetDescendants()) do
			if Child:IsA("BasePart") then
				Total += 1
			end
		end
		for i, Child : Instance in pairs(Char:GetDescendants()) do
			if Child:IsA("BasePart") then
				local OriginTransparency = Child.Transparency
				Child.Transparency = 1
				Loaded += 1
				coroutine.resume(coroutine.create(function()
					repeat
						wait()
					until Loaded == Total
					wait(i/100)
					local LightPart = Instance.new("Part", LightParts)
					LightPart.Size = Child.Size + Vector3.new(0.1, 0.1, 0.1)
					LightPart.CFrame = Child.CFrame
					LightPart.CanCollide = false
					LightPart.BrickColor = Player.TeamColor
					LightPart.Material = Enum.Material.Neon
					local Weld = Instance.new("Weld", LightPart)
					Weld.Part0 = LightPart
					Weld.Part1 = Child
					local Sound = Form:Clone()
					Sound.Parent = LightPart
					Sound:Play()
					Child.Transparency = OriginTransparency
					for i = 20, 1, -1 do
						LightPart.Transparency += 0.05
						wait()
					end
					wait(Sound.TimeLength/Sound.PlaybackSpeed)
					LightPart:Destroy()
				end))
			end
		end
		Char:WaitForChild("Humanoid").Died:Connect(function()
			for i, Child : Instance in pairs(Char:GetDescendants()) do
				if Child:IsA("BasePart") then
					wait(0.01)
					coroutine.resume(coroutine.create(function()
						Child.Anchored = true
						local LightPart = Instance.new("Part", LightParts)
						LightPart.Size = Child.Size + Vector3.new(0.1, 0.1, 0.1)
						LightPart.CFrame = Child.CFrame
						LightPart.CanCollide = false
						LightPart.BrickColor = Player.TeamColor
						LightPart.Material = Enum.Material.Neon
						local Weld = Instance.new("Weld", LightPart)
						Weld.Part0 = LightPart
						Weld.Part1 = Child
						local Sound = Form:Clone()
						Sound.Parent = LightPart
						Sound:Play()
						Child.Transparency = 1
						for i = 20, 1, -1 do
							LightPart.Transparency += 0.05
							wait()
						end
						wait(Sound.TimeLength/Sound.PlaybackSpeed)
						LightPart:Destroy()
					end))
				end
			end
		end)
	end)
end)
