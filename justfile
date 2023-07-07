user:
    apply-user
system:
    apply-system
update:
    update-dots
both:
    apply-system && apply-user
all:
    update-dots && apply-system && apply-user
