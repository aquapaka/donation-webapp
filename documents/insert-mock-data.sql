USE [donationdb]
GO
INSERT [dbo].[app_user] ([app_user_id], [date_of_birth], [email], [fullname], [gender], [password], [phone_number], [role], [username]) VALUES (987654321, CAST(N'2000-11-19' AS Date), N'aqua.tamlong@gmail.com', N'Hoàng Tâm Long', 0, N'aqua12345', 886332278, N'ADMIN', N'aquapaka')
GO
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (97654325, 4500000, N'Xây dựng đập ngăn nước tràn tại cửa ông', CAST(N'2022-06-26' AS Date), N'https://doanhnhanplus.vn/wp-content/uploads/2021/11/Hoover-Dam-lon-nhat-nuoc-my-20211105-dnplus-04.jpg', CAST(N'2022-02-23' AS Date), N'Xây dựng đập nước tại cửa ông', 50500000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654321, 750000, N'Cùng chung tay ủng hộ đồng bào vùng lũ lụt...', CAST(N'2022-06-25' AS Date), N'https://fs.vieportal.net/Files/57D0941E18374C0B9DA224FC11257CC8/image=jpeg/be43749e2e914c88a368fc2c699e97c0/anh%20noi%20dung%201.jpg', CAST(N'2022-01-27' AS Date), N'Ủng hộ đồng bào vùng lũ', 250000000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654322, 150000, N'Lớp học tình thương nay đã...', CAST(N'2022-09-12' AS Date), N'https://photo-cms-plo.zadn.vn/w800/Uploaded/2022/rykxqqskxq/2020_12_04/lop-hoc-tinh-thuong1_gmky.jpg', CAST(N'2022-01-30' AS Date), N'Ủng hộ xây dựng lớp học tình thương', 100500000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654323, 22500000, N'Xây dựng mái ấm yêu thương...', CAST(N'2022-07-23' AS Date), N'https://photo-cms-baonghean.zadn.vn/cw607/Uploaded/2021/ftmztftgknzm/2018_04_09/bna__mai_am_tinh_thuong4209964_942018.jpg', CAST(N'2022-02-23' AS Date), N'Xây dựng mái ấm yêu thương', 333000000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654324, 280000, N'Ủng hộ quỹ gamer', CAST(N'2022-05-25' AS Date), N'https://www.progamerreview.com/wp-content/uploads/2018/09/1-10.jpg', CAST(N'2022-01-22' AS Date), N'Dành tiền cho những người đam mê trong lĩnh vực chơi game', 105000000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654325, 8340000, N'Bắt đầu thu hoạch một vụ lúa mới', CAST(N'2022-01-27' AS Date), N'https://image.thanhnien.vn/w2048/Uploaded/2022/wpxlcqjwq/2022_01_03/gung1-7410.jpg', CAST(N'2022-04-25' AS Date), N'Ủng hộ người dân bị thiệt hại vụ mùa', 10000000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654327, 130003050, N'Những người không còn lành lặn như chúng ta, đã phải...', CAST(N'2023-05-06' AS Date), N'https://images.baodantoc.vn/uploads/2021/Th%C3%A1ng_11/Ng%C3%A0y%209/H%C3%A0/SL1-1636359797253.jpg', CAST(N'2022-02-28' AS Date), N'Ủng hộ người nghèo khuyết tật', 130000000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (987654328, 9240000, N'Buồn ghê chưa nè...', CAST(N'2022-02-22' AS Date), N'https://www.fvhospital.com/wp-content/uploads/2019/10/roi-loan-tram-cam-750x500px.jpg', CAST(N'2022-01-21' AS Date), N'Ủng hộ người bị trầm cảm', 25000000)
INSERT [dbo].[donation_event] ([donation_event_id], [current_donation_amount], [detail], [end_time], [images], [start_time], [title], [total_donation_amount]) VALUES (9876543216, 25150000, N'Đâu đó trong tôi bừng nắng hạ', CAST(N'2022-04-30' AS Date), N'https://nguyentuanhung.vn/wp-content/uploads/2021/03/pasted-image-0-6-1.png', CAST(N'2022-01-30' AS Date), N'Ủng hộ nhà thơ bừng nắng hạ', 25000000)
GO
