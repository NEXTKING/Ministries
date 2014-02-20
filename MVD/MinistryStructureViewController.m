//
//  MinistryStructureViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "MinistryStructureViewController.h"
#import "MinistryStructureCell.h"
#import "MinistryStructureDescriptionViewController.h"

@interface MinistryStructureViewController ()
{
    NSArray *departments;
    NSArray *mainOffices;
    NSArray *offices;
    NSArray *centers;
}

@end

@implementation MinistryStructureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    self.title = @"Структура";
    //UIImageView* image =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    //image.frame = _tableView.frame;
    //self.tableView.backgroundView = image;
    // _backgroundView.image = [UIImage imageNamed:@"grayBackground.jpg"];
    self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view from its nib.
    self.tableView.sectionHeaderHeight = 50;
    
    departments = [NSArray arrayWithObjects:
                   @"Следственный департамент",
                   @"Департамент государственной службы и кадров",
                   @"Департамент информационных технологий, связи и защиты информации",
                   @"Договорно-правовой департамент",
                   @"Департамент делопроизводства и работы с обращениями граждан и организаций",
                   @"Департамент по финансово-экономической политике и обеспечению социальных гарантий",
                   @"Организационно-аналитический департамент",
                   @"Департамент по материально-техническому и медицинскому обеспечению Министерства внутренних дел Российской Федерации", nil];
    
    mainOffices = [NSArray arrayWithObjects:
                   @"Главное командование внутренних войск",
                   @"Главное управление на транспорте",
                   @"Главное управление вневедомственной охраны",
                   @"Главное управление по обеспечению безопасности дорожного движения",
                   @"Главное управление по обеспечению охраны общественного порядка и координации взаимодействия с органами исполнительной власти субъектов Российской Федерации",
                   @"Главное управление по противодействию экстремизму",
                   @"Главное управление собственной безопасности",
                   @"Главное управление уголовного розыска",
                   @"Главное управление экономической безопасности и противодействия коррупции", nil];
    
    offices = [NSArray arrayWithObjects:
               @"Управление «К» МВД России",
               @"Управление по обеспечению безопасности лиц, подлежащих государственной защите",
               @"Управление по взаимодействию с институтами гражданского общества и средствами массовой информации",
               @"Управление по обеспечению безопасности крупных международных и массовых спортивных мероприятий",
               @"Организационно-штатное управление",
               @"Контрольно-ревизионное управление",
               @"Управление по организации дознания",
               @"Оперативное управление",
               @"Национальное центральное бюро Интерпола",
               @"Управление по обеспечению деятельности подразделений специального назначения и авиации", nil];
    centers = [NSArray arrayWithObjects:
               @"Главный информационно-аналитический центр",
               @"Экспертно-криминалистический центр",
               @"Главный центр связи и защиты информации",
               @"Главный центр спецперевозок",
               @"Главный центр административно-хозяйственного и транспортного обеспечения",
               @"ФКУ НПО «Спецтехника и Связь»",
               @"Всероссийский научно-исследовательский институт",
               @"ФКУ \"Центр кинологического обеспечения МВД России\"", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *hf = (UITableViewHeaderFooterView*) view;
    hf.contentView.backgroundColor = [UIColor colorWithRed:126.0/255.0 green:151.0/255.0 blue:157.0/255.0 alpha:1.0];
    [hf.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:20]];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return departments.count;
    else if (section == 1)
        return mainOffices.count;
    else if (section == 2)
        return offices.count;
    else
        return centers.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Департаменты";
    else if (section == 1)
        return @"Главные управления";
    else if (section == 2)
        return @"Управления";
    else
        return @"Центры";
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MinistryStructureCell";
    MinistryStructureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MinistryStructureCell" owner:self options:nil] objectAtIndex:0];
    }
    
    if (indexPath.section == 0)
        cell.mainLabel.text = departments[indexPath.row];
    else if (indexPath.section == 1)
        cell.mainLabel.text = mainOffices[indexPath.row];
    else if (indexPath.section == 2)
        cell.mainLabel.text = offices[indexPath.row];
    else
        cell.mainLabel.text = centers[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MinistryStructureDescriptionViewController *description = [[MinistryStructureDescriptionViewController alloc] init];
    [self.navigationController pushViewController:description animated:YES];
    
    
}

@end
