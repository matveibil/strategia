import pygame
import random

deployment_cost = 10
screen_height = 500
screen_width = 700
atack1 = 5
speed1 = 3
zavod = 0
fps = 60
hp1 = 5

screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("strategia na pygame")
clock = pygame.time.Clock()

class Area:
    def __init__(self, x, y, width, height, color):
        self.rect = Rect(x, y, width, height)
        self.fill_color = color

    def fill(self):
        draw.rect(window, self.fill_color, self.rect)

    def collidepoint(self, x, y):
        return self.rect.collidepoint(x, y)

    def colliderect(self, other_rect):
        return self.rect.colliderect(other_rect)

class Picture(Area):
    def __init__(self, filename, x, y, width, height, color=None):
        super().__init__(x, y, width, height, color)
        try:
            self.image = pygame.image.load(filename)
            self.image = pygame.transform.scale(self.image, (width, height))
        except:
            self.image = pygame.Surface((width, height))
            self.image.fill(color if color else BLUE)

    def draw(self, surface):
        surface.blit(self.image, (self.rect.x, self.rect.y))

class Soldier(Picture):
    def __init__(self, filename, x, y, width, height, hp, attack, speed, max_hp, is_moving):
        self.hp = hp
        self.max_hp = max_hp
        self.attack = attack
        self.damage = attack
        self.speed = speed
        self.alive = True
        self.is_moving = False

    def check(self):
        if self.alive:
            window.blit(self.image, (self.rect.x, self.rect.y))

    def move(self):
        if self.alive and self.is_moving:
            self.rect.x += self.speed

    def collision(self, enemy):
        if self.alive and enemy.alive:
            self.hp -= enemy.damage
            enemy.hp -= self.damage
            if self.hp <= 0:
                self.alive = False
                self.is_moving = False
            if enemy.hp <= 0:
                enemy.alive = False
                enemy.is_moving = False

blue_soldiers = [Soldier(filename='солдат.png', x=-100, y=350, width=60, height=50, hp=5, attack=3, speed=2, max_hp=5, color=BLUE), Soldier(filename='солдат.png', x=-100, y=350, width=60, height=50, hp=5, attack=3, speed=2, max_hp=5, color=BLUE), Soldier(filename='солдат.png', x=-100, y=350, width=60, height=50, hp=5, attack=3, speed=2, max_hp=5, color=BLUE)]

running = True
while running:
    screen.fill(0, 0, 0)

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    for soldier in blue_soldiers:
        soldier.move()
        soldier.check(screen)
    pygame.display.flip()
    clock.tick(FPS)

pygame.quit()
